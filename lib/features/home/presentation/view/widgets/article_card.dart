import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/features/cubit/home_cubit.dart';

class ArticleCard extends StatelessWidget {
  final ArticleDetailesModel articleDetailesModel;

  const ArticleCard({super.key, required this.articleDetailesModel});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return GestureDetector(
      onTap: () {
        cubit.onClickArticleCard(article: articleDetailesModel);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 322,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  articleDetailesModel.urlToImage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Text(
              articleDetailesModel.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "By: ${articleDetailesModel.author ?? ""}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
