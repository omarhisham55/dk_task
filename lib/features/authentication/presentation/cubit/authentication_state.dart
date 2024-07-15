part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class RememberMeToggleState extends AuthenticationState {
  final bool enabled;

  const RememberMeToggleState({required this.enabled});

  @override
  List<Object> get props => [enabled];
}

class TogglePasswordState extends AuthenticationState {
  final bool enabled;

  const TogglePasswordState({required this.enabled});

  @override
  List<Object> get props => [enabled];
}

final class GetUserLoadingState extends AuthenticationState {}

final class GetUserErrorState extends AuthenticationState {
  final String error;

  const GetUserErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetUserSuccessState extends AuthenticationState {}

final class SaveUserLoadingState extends AuthenticationState {}

final class SaveUserErrorState extends AuthenticationState {
  final String error;

  const SaveUserErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class SaveUserSuccessState extends AuthenticationState {}
