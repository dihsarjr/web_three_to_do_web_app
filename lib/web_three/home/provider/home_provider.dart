import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_3_t0_do_web_app/uttils/api_support.dart';

class HomeProvider with ChangeNotifier {
  late Client httpClient;

  late Web3Client ethClient;
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

  /// [addTodo] this function helps to add to-do
  Future<void> vote(
      {required BuildContext context, required String address}) async {
    httpClient = Client();
    ethClient = Web3Client(ApiSupport.endPoint, httpClient);
    Credentials key = EthPrivateKey.fromHex(ApiSupport.privatKey);

    final contract = await getContract();

    final function = contract.function("addTodo");

    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [EthereumAddress.fromHex(address), "TestTodo"]),
        chainId: 4);
  }
}
