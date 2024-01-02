import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_store/core/constants/colors.dart';
import 'package:online_store/core/constants/padding.dart';
import 'package:online_store/core/constants/textstyle.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late final TextEditingController _searchController = TextEditingController();
  bool isSearchBarVisible = false;
  bool isSearch = false;

  void _toggleSearchBar() {
    setState(() {
      isSearchBarVisible = !isSearchBarVisible;
      if (!isSearchBarVisible) {
        _searchController.clear();
        isSearch = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: xsmalltopside,
      // padding: allten,
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isSearchBarVisible
              ? Expanded(
                  child: AnimatedContainer(
                    width: isSearchBarVisible
                        ? MediaQuery.of(context).size.width - 80
                        : 0,
                    duration: const Duration(milliseconds: 10000),
                    child: TextField(
                      controller: _searchController,
                      style: mediumStyle15,
                      textAlign: TextAlign.justify,
                      onSubmitted: (value) {
                        setState(() {
                          isSearch = true;
                          log(isSearch.toString());
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_searchController.text.isNotEmpty) {
                                  isSearch = true;
                                  log(isSearch.toString());
                                }
                                log(isSearch.toString());
                              });
                            },
                            icon: const Icon(Icons.search)),
                        suffixIconColor: grey,
                        filled: true,
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: grey,
                        ),
                        alignLabelWithHint: true,
                        fillColor: whitish,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: whitish)),
                        focusColor: white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: whitish),
                        ),
                      ),
                      autofocus: true,
                    ),
                  ),
                )
              : Text(
                  'Online Store',
                  style: bold20,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  isSearchBarVisible ? Icons.cancel : Icons.search,
                  color: grey,
                ),
                onPressed: _toggleSearchBar,
                focusColor: white,
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: grey,
                ),
                focusColor: white,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
