import 'package:flutter/material.dart';

import '../widgets/article_list_builder.dart';

class SelectedCategoryView extends StatelessWidget {
  const SelectedCategoryView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            ArticleListBuilder(
              category: category,
            ),
          ],
        ),
      ),
    );
  }
}
