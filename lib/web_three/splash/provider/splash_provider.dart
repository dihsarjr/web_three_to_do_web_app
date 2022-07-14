import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:web_3_t0_do_web_app/web_three/home/home.dart';

class SplashProvider with ChangeNotifier {
  /// [_accessKeys] this string list hold all connected wallet address
  List<String> _accessKeys = [];
  List<String> get accessKeys => _accessKeys;

  /// [connectWallet] this function helps to connect user wallet
  Future<void> connectWallet({required BuildContext context}) async {
    if (ethereum != null) {
      try {
        _accessKeys = await ethereum!.requestAccount();
        log(_accessKeys.toString());
        navigateToHome(context: context, address: _accessKeys[0]);
      } on EthereumUserRejected {
        log('User rejected the modal');
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
  }

  /// [navigateToHome] this function helps to navigate user to home
  void navigateToHome(
      {required BuildContext context, required String address}) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (ctx) => Home(
          address: address,
        ),
      ),
    );
  }
}
