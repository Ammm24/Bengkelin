class KecamatanModel {
  final int id;
  final String name;

  KecamatanModel({required this.id, required this.name});

  factory KecamatanModel.fromJson(Map<String, dynamic> json) {
    return KecamatanModel(
      id: json['id'],
      name: json['name'],
    );
  }
}