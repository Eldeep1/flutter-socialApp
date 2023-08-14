import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/home_layout.dart';
import 'package:social_app/main_cubit/main_states.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


class MainCubit extends Cubit<MainStates>{

  MainCubit(): super(MainInitialStates());

  static MainCubit get(context)=>BlocProvider.of(context);

  bool isDark=true;

  bool toRef=false;

  void changeAppTheme({bool? fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
    }
    else
      isDark=!isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) => emit(ChangeAppThemeState()));
    emit(ChangeAppThemeState());
  }
  Color changeColorWithTheme(){
    if(isDark){
      if(toRef){
        toRef=false;
        emit(ChangTextColorState());
      }
      return Colors.white;
    }
    else{
      if(toRef==false){
        toRef=true;
        emit(ChangTextColorState());

      }
      return Colors.black;
    }
  }

  Color changeColorWithThemeReversed(){
    if(isDark){
      if(toRef){
        toRef=false;
        emit(ChangTextColorState());
      }
      return Colors.black;
    }
    else{
      if(toRef==false){
        toRef=true;
        emit(ChangTextColorState());

      }
      return Colors.white;
    }
  }

Widget knowingWhereToGoNext({
  required String? uId,
}){
      if(uId!=null){
        return HomeLayout();
      }
    else
      return LoginScreen();
}

}