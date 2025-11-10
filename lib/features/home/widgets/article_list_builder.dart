import 'package:flutter/material.dart';

import 'article_widget.dart';

class ArticleListBuilder extends StatelessWidget {
  const ArticleListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => const ArticleWidget(),
      itemCount: 10,
    );
  }
}
