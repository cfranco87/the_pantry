import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_pantry/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite =
        state.contains(meal); //does not edit just checks for meal

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; //this is how we remove a meal
    } else {
      state = [...state, meal];
      return true; //speard ... operator, updates list
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  //this provider returns instance of our notifier class
  return FavoriteMealsNotifier();
});
