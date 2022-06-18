import 'package:flutter/material.dart';
import 'package:sumission_2/models/restaurant.model.dart';
import 'package:sumission_2/pages/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/medium/" +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(id: restaurant.id))),
      ),
    );
  }
}
