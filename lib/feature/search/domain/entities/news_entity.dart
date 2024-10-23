import 'package:borsum/feature/search/data/models/news_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_entity.freezed.dart';

@freezed
class NewsEntity with _$NewsEntity {
  const factory NewsEntity({
    required int id,
    required String stock,
    required String title,
    required String description,
    required String image,
    required String article,
    required DateTime pubDate,
  }) = _NewsEntity;

  factory NewsEntity.empty() => NewsEntity(
        id: 0,
        stock: '',
        title: '',
        description: '',
        image: '',
        article: '',
        pubDate: DateTime.now(),
      );

  factory NewsEntity.fromModel(NewsModel model) => NewsEntity(
        id: model.id,
        stock: model.stock,
        title: model.title,
        description: model.description,
        image: model.image,
        article: model.article,
        pubDate: model.pubDate,
      );
}
