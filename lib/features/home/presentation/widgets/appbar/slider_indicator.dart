import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:dakahlia_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SliderProgress { low, midLow, midHigh, high }

class SliderIndicator extends StatefulWidget {
  final int index;
  final double value;
  const SliderIndicator({super.key, required this.value, required this.index});

  @override
  State<SliderIndicator> createState() => _SliderIndicatorState();
}

class _SliderIndicatorState extends State<SliderIndicator> {
  late double maxWidth;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final HomeCubit getCubit = HomeCubit.get(context);
      getCubit.getWidth(widget.index, widget.value, maxWidth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          maxWidth = constraints.maxWidth;
          final HomeCubit get = HomeCubit.get(context);
          return Stack(
            children: [
              Container(
                height: 10,
                width: maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.lightGrey,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 10,
                width: get.width[widget.index].toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: get.sliderColorProgress(
                    get.width[widget.index],
                    maxWidth,
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
