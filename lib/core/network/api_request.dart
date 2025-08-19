import "dart:convert";
import "dart:math";

import "package:http/http.dart" as http;
import "package:news_app/core/enum/status_key.dart";
import "package:news_app/core/models/article_model.dart";
import "package:news_app/core/models/sources_data_model.dart";
import "package:news_app/core/network/api_constants.dart";
import "package:news_app/core/network/end_point.dart";

abstract class ApiRequests {
   static Future <List<SourcesDtailesModel>> getSources  (String category) async {
    try {
      Map<String, dynamic> quaryPramenter = {
        "apiKey": ApiConstats.apiKey,
        "category": category,
      };
      final response = await http.get(
        Uri.https(ApiConstats.baseUrl, EndPoint.getSources, quaryPramenter),
      );

      var data = jsonDecode(response.body);
      SourcesDataModel sourcesDataModel;
      print(data.toString());
      
      if(response.statusCode==200 && data["status"]==StatusKey.ok.name){
        sourcesDataModel= SourcesDataModel.fromJson(data);
        return sourcesDataModel.sources;
      }else{
        print("API Error: ${data['message'] ?? 'Unknown error'}");
        return [];
      }

    } on Exception catch (e) {
      print("Exception: $e");
      return [];
    }
  }

   static Future <List<ArticleDetailesModel>> getArticles  (String source) async {
     try {
       Map<String, dynamic> quaryPramenter = {
         "apiKey": ApiConstats.apiKey,
         "sources": source,

       };
       final response = await http.get(
         Uri.https(ApiConstats.baseUrl, EndPoint.getArtical, quaryPramenter),
       );

       var data = jsonDecode(response.body);
       ArticleModel articleModel;

       if(response.statusCode==200 && data["status"]==StatusKey.ok.name){
         articleModel= ArticleModel.fromJson(data);
         return articleModel.sources;
       }else{
         print("API Error: ${data['message'] ?? 'Unknown error'}");
         return [];
       }

     } on Exception catch (e) {
       print("Exception: $e");
       return [];
     }
   }
}
