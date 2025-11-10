import 'package:flutter/material.dart';

import '../../../core/utils/categories_model.dart';
import '../views/selected_category_view.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.category});
  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedCategoryView(
              category: category.categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
              image: AssetImage(category.image), fit: BoxFit.fill),
        ),
        child: Center(
          child: Text(
            category.categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
