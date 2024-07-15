import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dakahlia_task/core/components/snack_bar.dart';
import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:dakahlia_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardCard extends StatelessWidget {
  const DashBoardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(120),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetProductsErrorState) {
            showSnackBar(context: context, text: state.error);
          }
        },
        builder: (context, state) {
          final HomeCubit manager = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetUserProductsLoadingState,
            fallback: (context) => const CircularProgressIndicator.adaptive(),
            builder: (context) {
              if (manager.userProducts.isEmpty) {
                return Center(
                  child: Text(
                    'No Products Available',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                );
              }
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 0.7,
                children: List.generate(
                  manager.userProducts.length,
                  (index) => CardItem(
                    index: index,
                    product: manager.userProducts[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
