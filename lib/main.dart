import 'package:borsum/app/initializer/app_initializer.dart';
import 'package:borsum/app/router/app_router.dart';
import 'package:borsum/app/theme/light/app_light_theme.dart';
import 'package:borsum/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        title: 'Borsum',
        debugShowCheckedModeBanner: false,
        // Theme
        theme: AppLightTheme().themeData,
        // Router
        routerConfig: AppRouter.router,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => Locator.searchBloc,
              ),
              BlocProvider(
                create: (_) => Locator.newsBloc,
              ),
              BlocProvider(
                create: (_) => Locator.newsSummaryCubit,
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }
}
