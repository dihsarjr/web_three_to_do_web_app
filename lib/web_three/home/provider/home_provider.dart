import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_3_t0_do_web_app/uttils/api_support.dart';

class HomeProvider with ChangeNotifier {
  String address = '';

  Future<DeployedContract> getContract() async {
    String abiFile = await rootBundle.loadString("assets/contract.json");

    String contractAddress = ApiSupport.contractAddress;

    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "Todo"),
        EthereumAddress.fromHex(contractAddress));
    log(contract.address.toString());
    log(contract.events.toString());
    address = contract.address.toString() + contract.events.toString();
    notifyListeners();
    return contract;
  }
}
