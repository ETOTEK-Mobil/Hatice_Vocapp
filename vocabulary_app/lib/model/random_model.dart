import 'package:json_annotation/json_annotation.dart';
part 'random_model.g.dart';

@JsonSerializable()
class RandomModel {
  String message;
  Word word;

  RandomModel({
    required this.message,
    required this.word,
  });

  factory RandomModel.fromJson(Map<String, dynamic> json) =>
      _$RandomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RandomModelToJson(this);
}

@JsonSerializable()
class Word {
  @JsonKey(name: '_id')
  String id;
  String word;
  String meaning;
  String pronunciation;
  String example;
  String level;

  Word({
    required this.id,
    required this.word,
    required this.meaning,
    required this.pronunciation,
    required this.example,
    required this.level,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['_id'] as String? ?? 'Unknown ID',
      word: json['word'] as String? ?? 'Unknown',
      meaning: json['meaning'] as String? ?? 'No meaning provided',
      pronunciation: json['pronunciation'] as String? ?? 'No pronunciation',
      example: json['example'] as String? ?? 'No example',
      level: json['level'] as String? ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
