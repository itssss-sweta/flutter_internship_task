import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/config/routes/route.dart';
import 'package:online_store/core/constants/key.dart';
import 'package:online_store/features/homepage.dart/data/models/product_model.dart';
import 'package:online_store/features/homepage.dart/presentation/cubit/search/cubit/search_cubit_cubit.dart';

List<String?> matchString(
  BuildContext context, {
  String? text,
  List<HomePageModel>? products,
}) {
  // Function(List<String>)? onSearchResults;
  try {
    if (text != null && text.isEmpty) {
      log('nothing entered');
    }
    if (text != null && text.isNotEmpty && products != null) {
      List<String> matchingString = products
          .where((product) =>
              product.title!.toLowerCase().contains(text.toLowerCase()) ||
              product.category!.toLowerCase().contains(text.toLowerCase()) ||
              product.description!.toLowerCase().contains(text.toLowerCase()))
          .map((product) => product.title as String)
          .toList();
      log(matchingString.toString());
      log(matchingString.length.toString());

      if (navigationKey.currentState != null) {
        navigationKey.currentState
            ?.pushNamed(Routes.searchScreen, arguments: text);
      }
      context.read<SearchCubitCubit>().searchProducts(text, products);
      return matchingString;
    }
  } catch (e) {
    throw Exception('Error: $e');
  }

  return [];
}
