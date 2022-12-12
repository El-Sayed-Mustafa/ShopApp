import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/on_boarding.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/cubit/AppStates.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/observer/observer.dart';
import 'package:shop_app/styles/themes.dart';

import 'network/local/chash_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  bool? isDark = CashHelper.getData(key: 'isDark');
  bool? onBoarding = CashHelper.getData(key: 'onboarding');

  print(onBoarding);

  runApp(MyApp( isDark,onBoarding));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  bool? onBoarding;

  MyApp(this.isDark,this.onBoarding);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => NewsCubit()..getBusiness(),
        // ),
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme:lightTheme,
              // darkTheme:ThemeData.dark(),
              // themeMode: AppCubit.get(context).isDark
              //     ? ThemeMode.light
              //     : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: onBoarding! ?LoginScreen(): OnBoardingScreen(),
            );
          }),
    );
  }
}


