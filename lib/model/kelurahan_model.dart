class KelurahanModel {
  final int id;
  final String name;

  KelurahanModel({required this.id, required this.name});

  factory KelurahanModel.fromJson(Map<String, dynamic> json) {
    return KelurahanModel(
      id: json['id'],
      name: json['name'],
    );
  }
}