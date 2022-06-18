import 'package:sumission_2/models/category.model.dart';
import 'package:sumission_2/models/customer-review.model.dart';
import 'package:sumission_2/models/menu.model.dart';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String city;

  String pictureId;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        // address: json["address"] == true ? json["address"] : "",
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
        // categories: json["categories"] == true
        //     ? List<Category>.from(
        //         json["categories"].map((x) => Category.fromJson(x)))
        //     : <Category>[],
        // menus: Menus.fromJson(json["menus"]),
        // customerReviews: json["customerReviews"] == true
        //     ? List<CustomerReview>.from(
        //         json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
        //     : <CustomerReview>[],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        // "address": address,
        "pictureId": pictureId,
        "rating": rating,
        // "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        // "menus": menus!.toJson(),
        // "customerReviews":
        //     List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
