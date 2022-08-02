import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_3_t0_do_web_app/web_three/home/provider/home_provider.dart';
import 'package:web_3_t0_do_web_app/web_three/splash/provider/splash_provider.dart';
import 'package:web_3_t0_do_web_app/web_three/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
      ),
    );
  }
}
