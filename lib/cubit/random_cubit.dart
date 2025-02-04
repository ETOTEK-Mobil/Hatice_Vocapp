import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/model/random_model.dart';
import 'package:vocabulary_app/services/random_service.dart';

class RandomCubit extends Cubit<RandomModel> {
  final RandomService _service = RandomService();
  final List<Word> _wordList = []; // Kelimeleri saklamak için bir liste

  RandomCubit()
      : super(RandomModel(
          message: 'Initializing...', // Başlangıç mesajı
          word: Word(
            id: '',
            word: '',
            meaning: '',
            pronunciation: '',
            example: '',
            level: '',
          ), // Boş bir Word nesnesi
        ));

  Future<void> fetchRandomWord() async {
    try {
      Word newWord;
      bool isWordInList;

      // Yeni kelime çek ve listede olup olmadığını kontrol et
      do {
        newWord = await _service.fetchRandomWord(); // Yeni kelimeyi çek
        isWordInList = _isWordInList(newWord); // Kelime listede mi?
      } while (isWordInList); // Kelime listede olduğu sürece yeniden çek

      _wordList.add(newWord); // Kelimeyi listeye ekle
      emit(RandomModel(
        message: 'Word fetched successfully', // Başarılı mesajı
        word: newWord, // Yeni kelime
      ));
    } catch (e) {
      print('Error fetching random word: $e'); // Hata durumunda logla
      emit(RandomModel(
        message: 'Failed to fetch word', // Hata mesajı
        word: Word(
          id: '',
          word: '',
          meaning: '',
          pronunciation: '',
          example: '',
          level: '',
        ), // Boş bir Word nesnesi
      ));
    }
  }

  // Kelimenin listede olup olmadığını kontrol eden yardımcı metot
  bool _isWordInList(Word newWord) {
    return _wordList.any((word) => word.id == newWord.id); // ID'ye göre kontrol
  }
}
