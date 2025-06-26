import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_watchlist_app/core/storage/shared_prefs.dart';
import 'package:stock_watchlist_app/core/constants/app_colors.dart';
import 'package:stock_watchlist_app/core/routes/app_routes.dart';
import 'package:stock_watchlist_app/core/utils/bloc_utils.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          systemNavigationBarColor: AppColors.bgGrey,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
    );
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) => MultiBlocProvider(
            providers: BlocUtils.appBlocs,
            child: GetMaterialApp(
              title: AppStrings.appTitle,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.dashboard,
              getPages: AppPages.routes,
            ),
          ),
    );
  }
}
