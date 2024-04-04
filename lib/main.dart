import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:foodie_fly/controller/blocs/category/category_bloc.dart';
import 'package:foodie_fly/controller/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly/controller/blocs/login/login_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/controller/blocs/signup/signup_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_password/toggle_password_cubit.dart';
import 'package:foodie_fly/controller/cubits/toggle_repasswod/toggle_repassword_cubit.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/splash/screen_splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc(),),
        BlocProvider(create: (context) => LoginBloc(),),
        BlocProvider(create: (context) => BottomNavigationBloc(),),
        BlocProvider(create: (context) => TogglepasswordCubit(),),
        BlocProvider(create: (context) => ToggleRepasswordCubit(),),
        BlocProvider(create: (context) => ProfileBloc(),),
        BlocProvider(create: (context) => CategoryBloc(),),
        BlocProvider(create: (context) => DishBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foodie Fly',
        theme: ThemeData(
          primaryColor: greenPointShade800,
          primarySwatch: greenMaterialColor,
          useMaterial3: true,
          fontFamily: 'K2D',
        ),
        home: const SplashScreenPage(),
      ),
    );
  }
}
