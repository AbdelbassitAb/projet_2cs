import 'package:flutter/material.dart';
import 'package:projet_2cs/config/config.dart';
import 'package:projet_2cs/screens/login.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';
import 'services/cloud_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [

          ChangeNotifierProvider<Auth>(create: (_) => Auth()),

        ],
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Montserrat',
              scaffoldBackgroundColor: Colors.white,
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                secondary: Colors.grey,
              ),
              textTheme: const TextTheme(
                headline1: TextStyle(
                  fontSize: 35,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                headline2: TextStyle(
                  fontSize: 26,
                  color: primaryColor,
                  fontWeight: FontWeight.normal,
                ),
                headline3: TextStyle(
                  fontSize: 17,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                headline4: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: Routes.routes,
            //home: Login(),
          );
        });
  }
}
