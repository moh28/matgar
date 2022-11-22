import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/shared/network/local/cache_helper.dart';
import 'package:matgar/shared/network/remote/dio_helper.dart';
import 'package:matgar/shared/styles/themes.dart';
import 'layout/login/login_screen.dart';
import 'layout/on_boarding_screen.dart';
import 'layout/shop/shop_layout.dart';
import 'models/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String?token = CacheHelper.getData(key: 'token');
  print('fffff${token}');
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayOut();
    } else {
      widget = LogInScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  Bloc.observer = MyBlocObserver();

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  late Widget? startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,

    );
  }
}
