import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/cubits/register_cubit/register_cubit.dart';
import 'package:shop_app/cubits/search_cubit/search_cubit.dart';
import 'package:shop_app/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/modules/onboarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');

  Widget widget;

  if (token != null) {
    widget = HomeLayout();
  } else {
    widget = OnBoardingScreen();
  }

  DioHelper.init();
  runApp(ShopApp(
    startWidget: widget,
  ));
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key, required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()
              ..homeModel
              ..categoriesModel),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
          fontFamily: 'Barlow',
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
