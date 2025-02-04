import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabulary_app/model/random_model.dart';
import 'package:http/http.dart' as http;
import 'package:vocabulary_app/services/routes/api_routes.dart';

class RandomRepo {
  Word parseWord(String response) {
    final decodedJson = jsonDecode(response);

    if (decodedJson == null || decodedJson.isEmpty) {
      throw Exception('API returned null or empty response');
    }

    if (!decodedJson.containsKey('word')) {
      throw Exception('Invalid API response: Missing "word" field');
    }

    // API yanıtındaki "word" alanını çıkar
    final wordJson = decodedJson['word'] as Map<String, dynamic>;
    return Word.fromJson(wordJson);
  }

  Future<Word> fetchRandomWord() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found!');
      }

      final response = await http.get(
        ApiRoutes.random.uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final word = parseWord(response.body);

        // API eksik veri döndürdü mü kontrol et
        if (word.word.isEmpty || word.meaning.isEmpty) {
          throw Exception("API returned invalid data");
        }

        return word;
      } else {
        throw Exception(
            'Failed to load random word (Status: ${response.statusCode})');
      }
    } catch (e) {
      print("Error fetching random word: $e");
      throw Exception("Failed to fetch word: $e");
    }
  }
}
