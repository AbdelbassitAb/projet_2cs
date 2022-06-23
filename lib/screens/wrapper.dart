import 'package:flutter/material.dart';
import 'package:projet_2cs/screens/layout.dart';
import 'package:projet_2cs/screens/loading.dart';
import 'package:projet_2cs/screens/login.dart';
import 'package:projet_2cs/services/cloud_service.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const route = "/";
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, _) {
      if (auth.isAuth)
        return Layout();
      else {
        return FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Login();
              };
              return Loading();
            });
      }
    });
  }
}
