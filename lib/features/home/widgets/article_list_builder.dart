import 'package:flutter/material.dart';

import '../../../data/model/article.dart';
import '../../../data/repo/repo_impl.dart';
import '../../../data/service/news_service.dart';
import 'article_widget.dart';

class ArticleListBuilder extends StatefulWidget {
  const ArticleListBuilder({
    super.key,
    required this.category,
  });
  final String category;
  @override
  State<ArticleListBuilder> createState() => _ArticleListBuilderState();
}

class _ArticleListBuilderState extends State<ArticleListBuilder> {
  late Future<List<Article>> future;

  @override
  void initState() {
    super.initState();
    future = fetchArticles();
  }

  Future<List<Article>> fetchArticles() async {
    final result =
        await NewsRepoImpl(NewsService()).fetchNews(category: widget.category);

    return result.fold(
      (failure) => throw Exception(failure.errMessage),
      (articles) => articles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('No articles found.')),
          );
        } else {
          final articles = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ArticleWidget(article: articles[index]),
              childCount: articles.length,
            ),
          );
        }
      },
    );
  }
}
