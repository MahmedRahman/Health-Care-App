
class ImageModel {
  final String id;
  final String url;
  final String name;
  final DateTime createdAt;

  ImageModel({
    required this.id,
    required this.url,
    required this.name,
    required this.createdAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'].toString(),
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}


