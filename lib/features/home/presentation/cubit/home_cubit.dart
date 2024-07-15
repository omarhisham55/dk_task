import 'package:dakahlia_task/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dakahlia_task/features/home/domain/entities/product.dart';
import 'package:dakahlia_task/features/home/domain/usecases/get_products_usecase.dart';
import 'package:dakahlia_task/features/home/domain/usecases/get_user_products_usecase.dart';
import 'package:dakahlia_task/features/home/presentation/widgets/appbar/slider_indicator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUsecase getProductsUsecase;
  final GetUserProductsUsecase getUserProductsUsecase;
  HomeCubit({
    required this.getProductsUsecase,
    required this.getUserProductsUsecase,
  }) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  void init() {
    getProducts();
  }

  late List<int> width = List.generate(products.length, (index) => 0);
  void getWidth(int index, double size, double maxWidth) {
    width[index] =
        ((((size / maxWidth) * 100).round() / 100) * maxWidth).round();
    emit(WidthState(index: index, width: width[index]));
  }

  Color sliderColorProgress(int size, double maxWidth) {
    SliderProgress progress = SliderProgress.low;
    size = ((size / maxWidth) * 100).round();
    if (size < 25) {
      progress = SliderProgress.low;
    } else if (size < 50) {
      progress = SliderProgress.midLow;
    } else if (size < 75) {
      progress = SliderProgress.midHigh;
    } else {
      progress = SliderProgress.high;
    }
    return switch (progress) {
      SliderProgress.low => Colors.red,
      SliderProgress.midLow => Colors.amber,
      SliderProgress.midHigh => Colors.orange,
      SliderProgress.high => Colors.green,
    };
  }

  List<Product> products = [];
  Future<void> getProducts() async {
    emit(GetProductsLoadingState());
    final response = await getProductsUsecase();
    emit(
      response.fold(
        (l) => GetProductsErrorState(error: l.props[0].toString()),
        (r) {
          products = r;
          return GetProductsSuccessState();
        },
      ),
    );
  }

  List<Product> userProducts = [];
  Future<void> getUserProducts(BuildContext context) async {
    emit(GetUserProductsLoadingState());
    final response = await getUserProductsUsecase(
        AuthenticationCubit.get(context).user!.id!);
    debugPrint(
        'AuthenticationCubit.get(context).user!.id!: ${AuthenticationCubit.get(context).user!.id!}');
    emit(
      response.fold(
        (l) => GetUserProductsErrorState(error: l.props[0].toString()),
        (r) {
          for (var element in r) {
            userProducts.addAll(
              products.where(
                (value) => value.id == element.productId,
              ),
            );
          }
          return GetUserProductsSuccessState();
        },
      ),
    );
  }
}
