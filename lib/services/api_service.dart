import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sumission_2/models/response.model.dart';
import 'package:sumission_2/models/response_detail.model.dart';

class ApiService {
  static final _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<Response> getAllrestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      // print(response.body);
      return Response.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<ResponseDetail> getDetailRestaurant(id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    // print(response.body);
    if (response.statusCode == 200) {
      return ResponseDetail.fromJson(json.decode(response.body));
    }
    throw Exception("Failed to load detail");
  }

  Future<Response> searchRestaurant(query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return Response.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load top headlines');
  }
}
