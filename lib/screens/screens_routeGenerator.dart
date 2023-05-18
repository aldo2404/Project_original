// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:fx_project/models/login_response_model.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/screens/forgotpasswordpage.dart';
import 'package:fx_project/screens/loginpage.dart';

class ScreenRouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    var dataargs = settings.arguments;

    switch (settings.name) {
      case '/loginpage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/passwordforgotpage':
        return MaterialPageRoute(builder: (_) => PasswordForgotPage());
      case '/environmentpage':
        for (var d in dataargs as List<DomainModel>) {
          print("${d.tojson()}");
        }
        return MaterialPageRoute(
            builder: (_) => EnvironmentPage(domains: dataargs));
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
