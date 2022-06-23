
import 'package:flutter/material.dart';
import 'package:projet_2cs/screens/layout.dart';
import 'package:projet_2cs/screens/login.dart';
import 'package:projet_2cs/screens/wrapper.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Wrapper.route: (_) => const Wrapper(),
    Login.route: (_) => const Login(),
    Layout.route: (_) => const Layout(),

  };
}
