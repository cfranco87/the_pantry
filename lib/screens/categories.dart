import 'package:flutter/material.dart';
import 'package:the_pantry/data/dummy_data.dart';
import 'package:the_pantry/models/meal.dart';
import 'package:the_pantry/screens/meals.dart';
import 'package:the_pantry/widgets/category_grid_item.dart';

import '../models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _animationController; //animation controller must be set before build method executes

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override //removed from device memory once widget is removed, keep memory lean
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    //will show new screen for each meal
    final filteredMeals = widget.availableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
          //slide animation
          position: Tween(
            begin: const Offset(0, 0.3), //0.3 = 30% down
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
                //more natural feel to transition
                parent: _animationController,
                curve: Curves.easeInOut),
          ),
          child: child),
    );
  }
}
