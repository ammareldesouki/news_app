import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/image_strings.dart';
import 'package:news_app/core/models/data.dart';
import 'package:news_app/core/services/app_setting_provider.dart';
import 'package:news_app/features/cubit/home_cubit.dart';
import 'package:news_app/features/home/presentation/pages/category_details_screen.dart';
import 'package:news_app/features/home/presentation/widgets/article_card.dart';
import 'package:news_app/features/home/presentation/widgets/category_card.dart';
import 'package:news_app/features/home/presentation/widgets/side_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Provider
        .of<AppSettingProvider>(context)
        .isDarkMode;
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            drawer: SideBar(
              onClikedHomme: () {
                cubit.onClickCategoryCard();
                Navigator.pop(context);
              },
            ),
            appBar: AppBar(
              title: Text(
                cubit.selectedCategory?.name ?? 'News',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: cubit.clickSerch
                      ? Container(
                    width: 200,
                    child: TextField(
                      controller: cubit.searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search articles...',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => cubit.onClickSearch(),
                        ),
                      ),
                      onChanged: (value) {
                        cubit.searchArticles(value);
                      },
                    ),
                  )
                      : GestureDetector(
                    onTap: () => cubit.onClickSearch(),
                    child: const ImageIcon(
                      AssetImage(TImages.searchIcon),
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            body: cubit.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: cubit.clickSerch && cubit.searchResults.isNotEmpty
                    ? _buildSearchResults(context, cubit)
                    : cubit.clickSerch && cubit.isSearchLoading
                    ? _buildSearchLoading()
                    : cubit.clickSerch &&
                    cubit.searchController.text.isNotEmpty &&
                    cubit.searchResults.isEmpty
                    ? _buildNoSearchResults(context, cubit)
                    : _buildMainContent(context, cubit),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: cubit.selectedArticle != null
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 413,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: dark ? Colors.white : Colors.black,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            cubit.selectedArticle!.urlToImage ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        cubit.selectedArticle!.description ??
                            cubit.selectedArticle!.title,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                            color:
                            dark ? Colors.black : Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "By: ${cubit.selectedArticle!.author ?? ""}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await cubit
                              .onClickShowArticle(cubit.selectedArticle!.url);
                          cubit.onClickArticleCard();
                        },
                        child: const Text("View Full Article"),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, HomeCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results for "${cubit.searchController.text}"',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              ArticleCard(
                articleDetailesModel: cubit.searchResults[index],
              ),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: cubit.searchResults.length,
        ),
      ],
    );
  }

  Widget _buildSearchLoading() {
    return const Center(
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

  Widget _buildNoSearchResults(BuildContext context, HomeCubit cubit) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No articles found for "${cubit.searchController.text}"',
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or check spelling',
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, HomeCubit cubit) {
    return cubit.selectedCategory == null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good Morning \n Here is Some News For You",
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CategoryCard(
              categoryModel: Data.categories[index],
              index: index,
              onClickCatagorycard: cubit.onClickCategoryCard,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: Data.categories.length,
        ),
      ],
    )
        : CategorydDtailsScreen(categoryId: cubit.selectedCategory!.id);
  }
}