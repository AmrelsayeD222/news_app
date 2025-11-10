import 'package:flutter/material.dart';

import 'article_list_builder.dart';
import 'categories_list_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: CategoriesListBuilder(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          ),
          SliverToBoxAdapter(
            child: ArticleListBuilder(
              category: category,
            ),
          ),
        ],
      ),
    );
  }
}
