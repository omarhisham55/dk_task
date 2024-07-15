import 'package:dakahlia_task/config/routes/routes.dart';
import 'package:dakahlia_task/core/components/button.dart';
import 'package:dakahlia_task/core/components/snack_bar.dart';
import 'package:dakahlia_task/core/components/text_fields.dart';
import 'package:dakahlia_task/core/utils/strings.dart';
import 'package:dakahlia_task/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dakahlia_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SaveUserSuccessState) {
          Navigator.pushNamed(context, Routes.homePage);
        }
        if (state is SaveUserErrorState) {
          showSnackBar(context: context, text: state.error);
        }
        if (state is SaveUserSuccessState ||
            state is GetUserSuccessState &&
                AuthenticationCubit.get(context).user != null) {
          HomeCubit.get(context).getUserProducts(context);
        }
      },
      builder: (context, state) {
        final AuthenticationCubit auth = AuthenticationCubit.get(context);
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppStrings.loginTitle,
                  style: TextStyle(color: Colors.grey),
                ),
                DefualtTextField(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 20,
                    top: 50,
                  ),
                  hint: AppStrings.usernameHintText,
                  controller: auth.username,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username required';
                    }
                    return null;
                  },
                ),
                DefualtTextField(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 20,
                  ),
                  hint: AppStrings.passwordHintText,
                  controller: auth.password,
                  obsecure: auth.obsecure,
                  suffixIcon: InkWell(
                    onTap: auth.togglePassword,
                    child: Icon(auth.obsecure
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Min 6 characters';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: auth.rememberMe,
                            onChanged: auth.toggleRememberMe,
                          ),
                          const Text(AppStrings.rememberMe),
                        ],
                      ),
                      const Text(AppStrings.forgotPassword),
                    ],
                  ),
                ),
                DefualtButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  text: AppStrings.login,
                  onPressed: () =>
                      formKey.currentState!.validate() ? auth.saveUser() : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
