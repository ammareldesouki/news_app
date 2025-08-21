import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/network/api_request.dart';
import 'package:news_app/features/home/presentation/widgets/article_card.dart';

class ArticleList extends StatelessWidget {
  final String sourceid;

  const ArticleList({super.key, required this.sourceid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleDetailesModel>>(
      future: ApiRequests.getArticles(sourceid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading articles'));
        }

        List<ArticleDetailesModel> articles = snapshot.data ?? [];

        if (articles.isEmpty) {
          return const Center(child: Text('No articles available'));
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              ArticleCard(articleDetailesModel: articles[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: articles.length,
        );
      },
    );
  }
}
