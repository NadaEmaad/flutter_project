import 'package:flutter/material.dart';
import 'package:travell_app/models/app_data.dart';
import 'package:travell_app/widgets/category_item.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 7 / 8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: categoriesData
          .map(
            (categoryData) => CategoryItem(
              categoryData.id,
              categoryData.title,
              categoryData.imageUrl,
            ),
          )
          .toList(),
    );
  }
}
