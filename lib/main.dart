import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/home_screen.dart';
import 'package:shop_app/modules/on_boarding.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/cubit/AppStates.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/observer/observer.dart';
import 'package:shop_app/styles/themes.dart';

import 'layout/shop_app/cubit/cubit.dart';
import 'network/local/chash_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  Widget widget;
  bool? isDark = CashHelper.getData(key: 'isDark');
  bool? onBoarding = CashHelper.getData(key: 'onboarding');
  String? token = CashHelper.getData(key: 'token');

  print(token);

  if(onBoarding!=null) {
    if(token!=null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }



  runApp(MyApp( isDark,widget));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  final Widget? startWidget;

  MyApp(this.isDark,this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return MaterialApp(
              theme:lightTheme,
              // darkTheme:ThemeData.dark(),
              // themeMode: AppCubit.get(context).isDark
              //     ? ThemeMode.light
              //     : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          }),
    );
  }
}


