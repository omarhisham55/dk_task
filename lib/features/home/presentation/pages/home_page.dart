import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/appbar/app_bar.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: dashBoardAppBar(context),
      body: const DashBoardCard(),
    );
  }
}
