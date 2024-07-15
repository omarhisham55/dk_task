part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class WidthState extends HomeState {
  final int index;
  final int width;

  const WidthState({required this.index, required this.width});

  @override
  List<Object> get props => [index, width];
}

final class GetProductsLoadingState extends HomeState {}

final class GetProductsErrorState extends HomeState {
  final String error;

  const GetProductsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetProductsSuccessState extends HomeState {}

final class GetUserProductsLoadingState extends HomeState {}

final class GetUserProductsErrorState extends HomeState {
  final String error;

  const GetUserProductsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetUserProductsSuccessState extends HomeState {}
