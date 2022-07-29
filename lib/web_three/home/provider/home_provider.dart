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

  /// [getContract] this function helps to get the contract from root bundle
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
  Future<void> addToDo(
      {required BuildContext context, required String addressValue}) async {
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
            parameters: [EthereumAddress.fromHex(addressValue), "TestTodo"]),
        chainId: 4);
  }

  /// [callFunction] this function helps call public functions
  Future<List<dynamic>> callFunction({
    required String name,
    required String addressValue,
  }) async {
    httpClient = Client();
    ethClient = Web3Client(ApiSupport.endPoint, httpClient);
    final contract = await getContract();
    final function = contract.function(name);
    List<dynamic> result = await ethClient.call(
      contract: contract,
      function: function,
      params: [
        EthereumAddress.fromHex(addressValue),
      ],
    );

    return result;
  }

  List<dynamic> todoListPublic = [];

  /// [getToDoList] this function helps to fetch all todos based on user address
  Future<void> getToDoList({
    required String name,
    required String addressValue,
  }) async {
    try {
      List<dynamic> todoList =
          await callFunction(name: name, addressValue: addressValue);
      log(todoList.toString());
      todoListPublic = todoList;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
