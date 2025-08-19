

class SourcesDataModel{
 final String status;
 final List<SourcesDtailesModel> sources;

 SourcesDataModel( {required this.status, required this.sources});

 factory SourcesDataModel.fromJson(Map<String,dynamic>json)=>
     SourcesDataModel(status: json["status"], sources:(json["sources"] as List).map((data){
       return SourcesDtailesModel.fromJson(data);
     }).toList());
}

class SourcesDtailesModel{
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  SourcesDtailesModel({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.url, 
    required this.category, 
    required this.language, 
    required this.country
  });

  factory SourcesDtailesModel.fromJson(Map<String, dynamic> json) =>
    SourcesDtailesModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      category: json["category"] ?? "",
      language: json["language"] ?? "",
      country: json["country"] ?? "",
    );
}