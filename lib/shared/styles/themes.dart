import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/main_cubit/main_cubit.dart';
import 'package:social_app/shared/components/constants.dart';


ThemeData darkTheme(context)=>ThemeData(

  primarySwatch: defaultColor,

  appBarTheme: AppBarTheme(
    // backgroundColor: Color.fromRGBO(64, 64, 64, 1),
    elevation: 20.0,
    backgroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(64, 64, 64, 1),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color.fromRGBO(64, 64, 64, 1),
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.light
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    // backgroundColor: Color.fromRGBO(64, 64, 64, 1),
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.black,
    selectedItemColor: defaultColor,
    elevation: 80.0,
  ),

  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: MainCubit.get(context).changeColorWithTheme(),
        // color: Colors.white,
      ),
    // bodyText2: TextStyle(
    //   fontSize: 18,
    //   fontWeight: FontWeight.w600,
    //   color: MainCubit.get(context).changeColorWithThemeReversed(),
    // ),
  ),

  scaffoldBackgroundColor: Color.fromRGBO(64, 64, 64, 1),
  //   scaffoldBackgroundColor: Colors.black,
fontFamily: 'Jannah',
);

ThemeData whiteTheme(context)=>ThemeData(
  fontFamily: 'Jannah',

  primarySwatch: defaultColor,

  scaffoldBackgroundColor: Colors.white,

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness: Brightness.dark
    ),
    titleTextStyle: TextStyle(
      color: Colors.red,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 100.0,
  ),

  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MainCubit.get(context).changeColorWithTheme(),
      ),
    // bodyText2: TextStyle(
    //   fontSize: 18,
    //   fontWeight: FontWeight.w600,
    //   color: MainCubit.get(context).changeColorWithThemeReversed(),
    // ),
  ),


);
