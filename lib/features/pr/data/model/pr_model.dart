import 'package:hive/hive.dart';

part 'pr_model.g.dart';

@HiveType(typeId: 0)
class PrModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String full_description;

  PrModel({
    required this.id,
    required this.name,
    required this.description,
    required this.full_description
  });
}
