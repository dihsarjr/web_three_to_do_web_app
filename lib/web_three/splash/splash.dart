import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_3_t0_do_web_app/web_three/splash/provider/splash_provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SplashProvider>(builder: (context, snapshot, _) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              snapshot.connectWallet(context: context);
            },
            child: const Text("Connect"),
          ),
        );
      }),
    );
  }
}
