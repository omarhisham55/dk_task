import 'package:dakahlia_task/config/dpi/dpi_controller.dart';
import 'package:dakahlia_task/config/sharedPrefs/shared_prefs.dart';
import 'package:dakahlia_task/features/authentication/data/models/user_model.dart';
import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';
import 'package:dakahlia_task/features/authentication/domain/usecases/get_user_usecase.dart';
import 'package:dakahlia_task/features/authentication/domain/usecases/save_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SaveUserUsecase saveUserUsecase;
  final GetUserUsecase getUserUsecase;
  AuthenticationCubit({
    required this.saveUserUsecase,
    required this.getUserUsecase,
  }) : super(AuthenticationInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool rememberMe = false;
  void toggleRememberMe([bool? value]) {
    rememberMe = value ?? false;
    emit(RememberMeToggleState(enabled: rememberMe));
  }

  bool obsecure = true;
  void togglePassword() {
    obsecure = !obsecure;
    emit(TogglePasswordState(enabled: obsecure));
  }

  void init() {
    final String? userCheck =
        DpiController.getIt<SharedPrefsController>().get('userId') as String?;
    debugPrint('userCheck: $userCheck');
    if (userCheck != null) {
      getUser(userCheck);
    }
  }

  User? user;
  Future<void> getUser(String id) async {
    emit(GetUserLoadingState());
    final response = await getUserUsecase(id);
    emit(
      response.fold(
        (l) => GetUserErrorState(error: l.props[0].toString()),
        (r) {
          user = r;
          return GetUserSuccessState();
        },
      ),
    );
  }

  Future<void> saveUser() async {
    emit(SaveUserLoadingState());
    final response = await saveUserUsecase(
      UserModel(username: username.text, password: password.text),
      rememberMe,
    );
    emit(
      response.fold(
        (l) => SaveUserErrorState(error: l.props[0].toString()),
        (r) {
          user = r;
          return SaveUserSuccessState();
        },
      ),
    );
  }
}
