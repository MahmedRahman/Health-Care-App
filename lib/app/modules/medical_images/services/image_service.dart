import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';


class ImageService {
  final String baseUrl = "http://159.198.36.67:8080";

  final String token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlaXNhYWJkYWxsYWg0OTkxMEBnbWFpbC5jb20iLCJpYXQiOjE3NTk2NjE5NDAsImV4cCI6MTg2NzY2MTk0MH0.VtPhcjVq_pvQPDS3i6nnxx49B2_ALPzu1EcaQav-RR4";

  Future<List<ImageModel>> fetchImages() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get/images'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images: ${response.statusCode}');
    }
  }

  Future<void> uploadImage(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/add/images'));

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath('image', filePath));

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }
}



