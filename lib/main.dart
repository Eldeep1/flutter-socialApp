import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/layout/home/cubit/home_cubit.dart';
import 'package:social_app/main_cubit/bloc_observer.dart';
import 'package:social_app/main_cubit/main_cubit.dart';
import 'package:social_app/main_cubit/main_states.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  DioHelper.init();

  Bloc.observer = MyBlocObserver();

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  var uId = CacheHelper.getData(key: 'uId');

  bool? isDark;

  MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit()..changeAppTheme(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: whiteTheme(context),
          darkTheme: darkTheme(context),
          themeMode:
              MainCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: MainCubit.get(context).knowingWhereToGoNext(uId: uId),
        ),
      ),
    );
  }
}
