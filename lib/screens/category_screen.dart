import 'package:flutter/material.dart';
import 'package:travell_app/screens/category_body.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const id = "CategoryScreen";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CategoryBody(),
    );
  }
}
