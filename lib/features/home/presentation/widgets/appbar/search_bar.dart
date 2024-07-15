import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: const MaterialStatePropertyAll(AppColors.lightGrey),
      leading: const Icon(
        Icons.search,
        color: AppColors.semiDarkGrey,
      ),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )),
      hintText: 'Search',
      hintStyle: const MaterialStatePropertyAll(
        TextStyle(color: AppColors.semiDarkGrey),
      ),
    );
  }
}
