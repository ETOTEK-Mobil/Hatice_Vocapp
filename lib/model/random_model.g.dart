// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomModel _$RandomModelFromJson(Map<String, dynamic> json) => RandomModel(
      message: json['message'] as String,
      word: Word.fromJson(json['word'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RandomModelToJson(RandomModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'word': instance.word,
    };

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      '_id': instance.id,
      'word': instance.word,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'example': instance.example,
      'level': instance.level,
    };
