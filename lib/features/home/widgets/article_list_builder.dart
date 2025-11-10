import 'package:flutter/material.dart';

import '../../../data/model/article.dart';
import '../../../data/repo/repo_impl.dart';
import '../../../data/service/news_service.dart';
import 'article_widget.dart';

class ArticleListBuilder extends StatefulWidget {
  const ArticleListBuilder({
    super.key,
  });

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
        await NewsRepoImpl(NewsService()).fetchNews(category: 'general');

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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No articles found.'));
        } else {
          final articles = snapshot.data!;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: articles.length,
            itemBuilder: (context, index) =>
                ArticleWidget(article: articles[index]),
          );
        }
      },
    );
  }
}
