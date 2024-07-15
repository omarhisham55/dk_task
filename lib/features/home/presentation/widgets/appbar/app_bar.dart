import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dakahlia_task/core/components/horizontal_divider.dart';
import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:dakahlia_task/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dakahlia_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/appbar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar dashBoardAppBar(BuildContext context) => AppBar(
      leading: Container(),
      leadingWidth: 0,
      title: const SizedBox(
        height: 35,
        width: 500,
        child: AppSearchBar(),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chat_bubble_rounded,
            size: 20,
            color: AppColors.semiDarkGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.support,
            size: 20,
            color: AppColors.semiDarkGrey,
          ),
        ),
        const SizedBox(width: 100),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: AppColors.semiDarkGrey,
          ),
        ),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final AuthenticationCubit auth = AuthenticationCubit.get(context);
            return ConditionalBuilder(
              condition: auth.user != null,
              fallback: (context) => Container(),
              builder: (context) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HorizontalDivider(
                      width: 1,
                      height: 20,
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text(auth.user!.username.toString()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.semiDarkGrey,
                      ),
                    ),
                    const CircleAvatar(),
                    const SizedBox(width: 12),
                  ],
                );
              },
            );
          },
        ),
        IconButton(
          onPressed: () => HomeCubit.get(context).logout(context),
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
      ],
    );
