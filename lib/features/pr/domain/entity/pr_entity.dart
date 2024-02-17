class PrEntity {
  final String id;
  String title;
  String description;
  String full_description;

  PrEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.full_description,
  });
  PrEntity copyWith(PrEntity? entity) {
    return PrEntity(
      id: id,
      title: entity?.title ?? title,
      description: entity?.description ?? description,
      full_description: entity?.full_description ?? full_description,
    );
  }
}
