import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/category_model.dart';
import 'package:news_app/core/network/api_request.dart';
import 'package:news_app/features/home/presentation/pages/category_details_screen.dart';
import 'package:news_app/features/home/presentation/widgets/article_card.dart';
import 'package:news_app/features/home/presentation/widgets/category_card.dart';
import 'package:news_app/features/home/presentation/widgets/side_bar.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/models/data.dart' show Data;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool index=false;
  CategoryModel? _Selectedcategory;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<ArticleDetailesModel> _searchResults = [];
  bool _isSearchLoading = false;

  onClickCategoryCard(CategoryModel category){
    _Selectedcategory=category;
    _clearSearch();
    print(_Selectedcategory?.id);
    setState(() {

    });
  }

  onClickHome(){
    _Selectedcategory=null;
    _clearSearch();
    setState(() {});
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _clearSearch();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _searchResults.clear();
    _isSearchLoading = false;
  }

  Future<void> _performSearch(String query) async {
    if (query
        .trim()
        .isEmpty) {
      setState(() {
        _searchResults.clear();
        _isSearchLoading = false;
      });
      return;
    }

    setState(() {
      _isSearchLoading = true;
    });

    try {
      // Search across all sources for articles containing the keyword
      final List<ArticleDetailesModel> results =
      await ApiRequests.searchArticles(query);

      setState(() {
        _searchResults = results;
        _isSearchLoading = false;
      });
    } catch (e) {
      print('Search error: $e');
      setState(() {
        _isSearchLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( _Selectedcategory?.name?? "Home",style: Theme.of(context).textTheme.titleMedium,),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: _isSearching
                ? Container(
              width: 200,
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: _toggleSearch,
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _performSearch(value);
                  } else {
                    _clearSearch();
                  }
                },
              ),
            )
                : GestureDetector(
              onTap: _toggleSearch,
              child: ImageIcon(AssetImage(TImages.searchIcon), size: 35),
            ),
          )
        ],

      ),
      drawer: SideBar(onClikedHomme: onClickHome,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _isSearching && _searchResults.isNotEmpty
              ? _buildSearchResults()
              : _isSearching && _isSearchLoading
              ? _buildSearchLoading()
              : _isSearching && _searchController.text.isNotEmpty &&
              _searchResults.isEmpty
              ? _buildNoSearchResults()
              : _buildMainContent(),
        ),
      )
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results for "${_searchController.text}"',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              ArticleCard(
                articleDetailesModel: _searchResults[index],
              ),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: _searchResults.length,
        ),
      ],
    );
  }

  Widget _buildSearchLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Searching articles...'),
        ],
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No articles found for "${_searchController.text}"',
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'Try different keywords or check spelling',
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return _Selectedcategory == null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Good Morning \n Here is Some News For You", style: Theme
            .of(context)
            .textTheme
            .titleMedium,),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CategoryCard(
                categoryModel: Data.categories[index],
                index: index,
                onClickCatagorycard: onClickCategoryCard,
                );
            },
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemCount: Data.categories.length
        ),
      ],
    )
        : CategorydDtailsScreen(categoryName: _Selectedcategory?.id ?? "");
  }
}
