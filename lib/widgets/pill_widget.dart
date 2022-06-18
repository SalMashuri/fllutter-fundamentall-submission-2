import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sumission_2/models/category.model.dart';

class PillWidget extends StatelessWidget {
  final List<Category> foods;

  const PillWidget(this.foods, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: generateRandomColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          foods.single.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ),
    );
  }

  Color generateRandomColor() =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
