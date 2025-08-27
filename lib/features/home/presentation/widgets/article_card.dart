import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/services/app_setting_provider.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatelessWidget{
  final ArticleDetailesModel articleDetailesModel;

  const ArticleCard({super.key, required this.articleDetailesModel});
  @override
  Widget build(BuildContext context) {
    bool dark = Provider
        .of<AppSettingProvider>(context)
        .isDarkMode;

    return  Container(
      padding: EdgeInsets.all(10),
    height:  322,
     width: double.infinity,
     decoration: BoxDecoration(
         border: Border.all(color: dark ? Colors.white : Colors.black),
       borderRadius: BorderRadius.circular( 16)
     ),
     child: Column(

       children: [
         SizedBox(
             height: 220,
             width: double.infinity,
             child:

             ClipRRect(
             
             borderRadius: BorderRadius.circular(16),
             child: Image.network(
               articleDetailesModel.urlToImage ?? "",
             ),
             )

         ),

         Text(articleDetailesModel.title,style: Theme.of(context).textTheme.bodyMedium,),
         Spacer(),
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
