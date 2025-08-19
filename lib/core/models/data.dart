import 'package:news_app/core/constants/image_strings.dart';
import 'package:news_app/core/models/category_model.dart';

class Data {

   static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      name: 'General',
      imageUrl:TImages.lightGeneralphoto,
    ),
    CategoryModel(
      id: 'business',
      name: 'Business',
      imageUrl: TImages.lightBusniessphoto,
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Entertainment',
      imageUrl: TImages.lightEntertainmentphoto
    ),
    CategoryModel(
      id: 'technology',
      name: 'Technology',
      imageUrl:TImages.lightTechnologyphoto,
    ),
    CategoryModel(
      id: 'science',
      name: 'Science',
      imageUrl:TImages.lightSciencephoto,
    ),
    CategoryModel(
      id: 'health',
      name: 'Health',
      imageUrl: TImages.lightHealthphoto,
    ),
    CategoryModel(
      id: 'sports',
      name: 'Sports',
      imageUrl:TImages.lightSportsphoto,
    ),
  ];
}