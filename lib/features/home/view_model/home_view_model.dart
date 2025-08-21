import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/category_model.dart';
import 'package:news_app/core/models/sources_data_model.dart';
import 'package:news_app/core/network/api_request.dart';

class HomeViewModel extends ChangeNotifier {
  List<SourcesDtailesModel> _sources = [];
  int _selectedTabIndex = 0;
  bool _isLoading = false;
  CategoryModel? _selectedCategory;
  List<ArticleDetailesModel> _articles = [];

  List<SourcesDtailesModel> get sources => _sources;

  List<ArticleDetailesModel> get articles => _articles;

  CategoryModel? get selectedCategory => _selectedCategory;

  int get currentTapIndex => _selectedTabIndex;

  bool get isLoading => _isLoading;

  Future<void> loadSources(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _sources = await ApiRequests.getSources(categoryId);
    } catch (e) {
      print('Error loading sources: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void onClickCategoryCard({CategoryModel? category}) {
    _selectedCategory = category;

    notifyListeners();
  }

  Future<void> setCurrentTapIndex(int index) async {
    _selectedTabIndex = index;
    await getArticles(_sources[index].id);

    notifyListeners();
  }

  Future<void> getArticles(String sourceId) async {
    try {
      _articles = await ApiRequests.getArticles(sourceId);
    } catch (e) {
      print('Error loading articles: $e');
    }

    notifyListeners();
  }
}
