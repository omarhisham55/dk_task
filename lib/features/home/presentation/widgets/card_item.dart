import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:dakahlia_task/features/home/domain/entities/product.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/appbar/slider_indicator.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/circular_progress_feddans.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final int index;
  final Product product;
  const CardItem({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ORCHARD ${index + 1}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          // scale and feddans
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.feddans.toString(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'Feddans',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Expanded(
                    child: CircularProgressFeddans(
                      image: product.img.data ?? [],
                      max: 600,
                      value: product.feddans.toDouble(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // slider and status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.launch_rounded,
                                  color: AppColors.lightGrey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${product.size} mm',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            SliderIndicator(
                              index: index,
                              value: product.size.toDouble(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Pest Status',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
