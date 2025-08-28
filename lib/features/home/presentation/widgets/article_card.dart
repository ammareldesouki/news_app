import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/services/app_setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget{
  final ArticleDetailesModel articleDetailesModel;

  const ArticleCard({super.key, required this.articleDetailesModel});

  Future<void> _launchUrl(url) async {
    final Uri uri = Uri.parse(url);
    print("0===================================0");
    if (await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      print("-------------------");
    }
  }

  void _showArticleBottomSheet(BuildContext context, bool dark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6,
              decoration: BoxDecoration(
                color: dark ? Colors.white : Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: articleDetailesModel.urlToImage ?? ":",
                              progressIndicatorBuilder: (context, url,
                                  downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              ),

                            ),
                          const SizedBox(height: 16),


                          Text(
                            articleDetailesModel.content!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                color: dark ? Colors.black : Colors.white),
                          ),

                        ],
                      ),
                    ),
                  ),
                  // Action buttons
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              _launchUrl(articleDetailesModel.url);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dark ? Colors.black : Colors
                                  .white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('View Full Article', style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Provider
        .of<AppSettingProvider>(context)
        .isDarkMode;

    return GestureDetector(
      onTap: () => _showArticleBottomSheet(context, dark),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 322,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: dark ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          children: [
            SizedBox(
                height: 220,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: articleDetailesModel.urlToImage ?? "",
                    progressIndicatorBuilder: (context, url,
                        downloadProgress) =>
                        CircularProgressIndicator(
                            value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )
            ),
            Expanded(
                child: Text(
                  articleDetailesModel.title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                      "By: ${articleDetailesModel.author ?? ""}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                          color: Colors.grey
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
