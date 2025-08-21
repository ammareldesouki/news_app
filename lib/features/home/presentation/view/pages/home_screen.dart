import 'package:flutter/material.dart';
import 'package:news_app/core/constants/image_strings.dart';
import 'package:news_app/core/models/data.dart';
import 'package:news_app/features/home/presentation/view/pages/category_details_screen.dart';
import 'package:news_app/features/home/presentation/view/widgets/category_card.dart';
import 'package:news_app/features/home/presentation/view/widgets/side_bar.dart';
import 'package:news_app/features/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, provider, _) {
          return Scaffold(
            drawer: SideBar(onClikedHomme: () {
              provider.onClickCategoryCard();
              Navigator.pop(context);
            },),
            appBar: AppBar(
              title: Text(
                provider.selectedCategory?.name ?? 'News',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ImageIcon(
                    const AssetImage(TImages.searchIcon),
                    size: 35,
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
                    categoryId: provider.selectedCategory!.id),
              ),
            ),
          );
        },
      ),
    );
  }
}