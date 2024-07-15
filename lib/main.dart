import 'package:dakahlia_task/config/dpi/dpi_controller.dart';
import 'package:dakahlia_task/config/routes/routes.dart';
import 'package:dakahlia_task/config/sharedPrefs/shared_prefs.dart';
import 'package:dakahlia_task/config/theme/theme.dart';
import 'package:dakahlia_task/core/bloc_observer.dart';
import 'package:dakahlia_task/core/components/snack_bar.dart';
import 'package:dakahlia_task/core/utils/strings.dart';
import 'package:dakahlia_task/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dakahlia_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DpiController.init();
  if (kDebugMode) {
    Bloc.observer = MyBlocObserver();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar(
          context: context,
          text: 'This app works only on web. Please open it in a web browser.',
          duration: const Duration(seconds: 5),
        );
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DpiController.getIt<AuthenticationCubit>()..init(),
        ),
        BlocProvider(
          create: (context) => DpiController.getIt<HomeCubit>()..getProducts(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: AppTheme.theme,
        onGenerateRoute: OnGenerateRoute.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute:
            DpiController.getIt<SharedPrefsController>().get('userId') == null
                ? Routes.auth
                : Routes.homePage,
      ),
    );
  }
}
