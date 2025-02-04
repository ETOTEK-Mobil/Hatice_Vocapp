import 'package:flutter/material.dart';
import 'package:vocabulary_app/model/random_model.dart';

class WordCard extends StatelessWidget {
  final Word word; // WordModel verisi

  const WordCard(
      {Key? key,
      required this.word,
      required String meaning,
      required String pronunciation,
      required String example,
      required String level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink,
      elevation: 8.0, // Kartın gölgesini ekliyoruz
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15.0), // Kart kenarlarını yuvarlatıyoruz
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              word.word, // Kelimenin ismini gösteriyoruz
              style: TextStyle(
                color: Colors.purple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              word.meaning, // Kelimenin anlamını gösteriyoruz
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Pronunciation: ${word.pronunciation}', // Kelimenin telaffuzunu gösteriyoruz
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Level: ${word.level}', // Kelimenin seviyesini gösteriyoruz
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Example: ${word.example}', // Kelimenin örnek cümlesini gösteriyoruz
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
