import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_pantry/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
