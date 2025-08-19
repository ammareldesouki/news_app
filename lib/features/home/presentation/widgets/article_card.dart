import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';

import '../../../../core/constants/image_strings.dart';

class ArticleCard extends StatelessWidget{
  final ArticleDetailesModel articleDetailesModel;

  const ArticleCard({super.key, required this.articleDetailesModel});
  @override
  Widget build(BuildContext context) {

    return  Container(
      padding: EdgeInsets.all(10),
    height:  322,
     width: double.infinity,
     decoration: BoxDecoration(
       border: Border.all(color: Colors.black),
       borderRadius: BorderRadius.circular( 16)
     ),
     child: Column(

       children: [
         Expanded(
           child: ClipRRect(
             borderRadius: BorderRadius.circular(16),
             child: Image.network(
               articleDetailesModel.urlToImage ??
                   "https://via.placeholder.com/150",
               fit: BoxFit.cover,
               errorBuilder: (context, error, stackTrace) {
                 return Image.asset(
                   TImages.darkapplogo, // your local fallback image
                   fit: BoxFit.cover,
                 );
               },
               loadingBuilder: (context, child, loadingProgress) {
                 if (loadingProgress == null) return child;
                 return const Center(child: CircularProgressIndicator());
               },
             ),
           ),
         ),


         Text(articleDetailesModel.title,style: Theme.of(context).textTheme.bodyMedium,),

         Row(
           children: [
             Expanded(child: Text("By: ${articleDetailesModel.author??""}", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 2, ))
           ],
         )


       ],
     ),

    );



  }


}
