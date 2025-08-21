import 'package:flutter/material.dart';
import 'package:news_app/core/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final CategoryModel categoryModel;
  final Function onClickCatagorycard;

  const CategoryCard({
    super.key,
    required this.categoryModel,
    required this.index,
    required this.onClickCatagorycard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClickCatagorycard(category: categoryModel); // Use named parameter
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(categoryModel.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: index % 2 == 0
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Directionality(
            textDirection: index % 2 == 0
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "  View All",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}