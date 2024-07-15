import 'package:dakahlia_task/core/utils/images.dart';
import 'package:dakahlia_task/core/utils/strings.dart';
import 'package:dakahlia_task/features/authentication/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Image.asset(
              AppImages.backgroundImg,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(child: LoginForm(formKey: formKey)),
                const Text(
                  AppStrings.policy,
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
