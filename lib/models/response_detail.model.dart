import 'dart:convert';

import 'package:sumission_2/models/restaurant.model.dart';
import 'package:sumission_2/models/restaurant_detail.model.dart';

class ResponseDetail {
  ResponseDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantDetail restaurant;

  factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
