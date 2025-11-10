import 'package:flutter/material.dart';

import '../../../data/model/article.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            article.urlToImage ??
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReJ-KJe8UQN3HaEhwM6vLiXodYapsJqdSEaA&s',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
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
