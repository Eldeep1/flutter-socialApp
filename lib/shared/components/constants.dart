import 'package:flutter/material.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'components.dart';



const defaultColor = Colors.blue;

void singOut(context) {
  CacheHelper.removeData(key: 'token')
      .then((value) => navigateAndFinish(context, LoginScreen()));
}

String token = CacheHelper.getData(key: 'token');
