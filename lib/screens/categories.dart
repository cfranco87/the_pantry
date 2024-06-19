import 'package:flutter/material.dart';
import 'package:the_pantry/data/dummy_data.dart';
import 'package:the_pantry/models/meal.dart';
import 'package:the_pantry/screens/meals.dart';
import 'package:the_pantry/widgets/category_grid_item.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    //will show new screen for each meal
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // alt to using availableCategories.map((category) =>
        //CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CatergoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
