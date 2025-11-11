import 'package:flutter/material.dart';

import 'article_list_builder.dart';
import 'categories_list_builder.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.category});
  final String category;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _refreshKey = 0;

  Future<void> _onRefresh() async {
    setState(() {
      _refreshKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            const SliverToBoxAdapter(
              child: CategoriesListBuilder(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            ArticleListBuilder(
              key: ValueKey(_refreshKey),
              category: widget.category,
            ),
          ],
        ),
      ),
    );
  }
}
