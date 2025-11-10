import 'package:flutter/material.dart';

import '../../../core/utils/categories_model.dart';
import 'category_widget.dart';

class CategoriesListBuilder extends StatelessWidget {
  const CategoriesListBuilder({super.key});
  final List<CategoriesModel> categories = const [
    CategoriesModel(
        image: 'assets/images/business.avif', categoryName: "Business"),
    CategoriesModel(
        image: 'assets/images/entertaiment.avif',
        categoryName: "Entertainment"),
    CategoriesModel(
        image: 'assets/images/general.avif', categoryName: "General"),
    CategoriesModel(image: 'assets/images/health.avif', categoryName: "Health"),
    CategoriesModel(
        image: 'assets/images/science.avif', categoryName: "Science"),
    CategoriesModel(image: 'assets/images/sports.avif', categoryName: "Sports"),
    CategoriesModel(
        image: 'assets/images/technology.jpeg', categoryName: "Technology"),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            CategoryWidget(category: categories[index]),
        itemCount: categories.length,
      ),
    );
  }
}
