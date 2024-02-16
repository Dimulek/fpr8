import 'package:fpr8/features/pr/data/model/pr_model.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';

extension PrMapperModel on PrModel {
  PrEntity toEntity() {
    return PrEntity(
      id: id,
      title: name,
      description: description,
      full_description: full_description,
    );
  }
}

extension PrMapperEntity on PrEntity {
  PrModel toModel() {
    return PrModel(
      id: id,
      name: title,
      description: description,
      full_description: full_description,
    );
  }
}
