import 'package:flutter/material.dart';

import '../../../data/model/article.dart';
import '../views/article_detalis_view.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if ((article.url?.isNotEmpty ?? false)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetalisView(url: article.url!),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No URL available for this article.'),
                ),
              );
            }
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
                      ? Image.network(
                          article.urlToImage!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink()),
        ),
        const SizedBox(height: 5),
        Text(
          article.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          article.description ?? '',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
