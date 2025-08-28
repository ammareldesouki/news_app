import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/image_strings.dart';
import 'package:news_app/core/models/data.dart';
import 'package:news_app/core/services/app_setting_provider.dart';
import 'package:news_app/features/cubit/home_cubit.dart';
import 'package:news_app/features/home/presentation/view/pages/category_details_screen.dart';
import 'package:news_app/features/home/presentation/view/widgets/category_card.dart';
import 'package:news_app/features/home/presentation/view/widgets/side_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dark = Provider.of<AppSettingProvider>(context).isDarkMode;
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),

      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, provider) {
          var provider = HomeCubit.get(context);
          return Scaffold(
            drawer: SideBar(
              onClikedHomme: () {
                provider.onClickCategoryCard();
                Navigator.pop(context);
              },
            ),
            appBar: AppBar(
              title: Text(
                provider.selectedCategory?.name ?? 'News',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: provider.clickSerch
                      ? TextFormField()
                      : GestureDetector(
                          onTap: () {
                            provider.onClickSearch();
                          },

                          child: ImageIcon(
                            const AssetImage(TImages.searchIcon),
                            size: 35,
                          ),
                        ),
                ),
              ],
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: provider.selectedCategory == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Morning \n Here is Some News For You",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return CategoryCard(
                                      categoryModel: Data.categories[index],
                                      index: index,
                                      onClickCatagorycard:
                                          provider.onClickCategoryCard,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 15),
                                  itemCount: Data.categories.length,
                                ),
                              ],
                            )
                          : CategorydDtailsScreen(
                              categoryId: provider.selectedCategory!.id,
                            ),
                    ),
                  ),

            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: provider.selectedArticle != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 413,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: dark ? Colors.white : Colors.black,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 6,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 220,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  provider.selectedArticle!.urlToImage ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              provider.selectedArticle!.description ??
                                  provider.selectedArticle!.title,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: dark ? Colors.black : Colors.white,
                                  ),
                            ),
                          ),

                          Row(
                            children: [
                              Text(
                                "By: ${provider.selectedArticle!.author ?? ""}",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                provider.onClickShowArticle(
                                  provider.selectedArticle!.url,
                                );
                                provider.onClickArticleCard();
                              },
                              child: Text("View Full Articel"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Text(""),
          );
        },
      ),
    );
  }
}
