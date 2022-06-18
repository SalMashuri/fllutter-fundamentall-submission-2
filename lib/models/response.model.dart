import 'dart:convert';

import 'package:sumission_2/models/restaurant.model.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.error,
    this.message,
    this.count,
    this.founded,
    required this.restaurants,
  });

  bool error;
  String? message;
  int? count;
  bool? founded;
  List<Restaurant> restaurants;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List).map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
