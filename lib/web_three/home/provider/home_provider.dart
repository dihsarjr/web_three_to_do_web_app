import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_3_t0_do_web_app/uttils/api_support.dart';
import 'package:web_3_t0_do_web_app/web_three/home/models/todo_model.dart';

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

  /// [addTodoLoadingState] this variable track the loading state of [addToDo]
  bool addTodoLoadingState = false;

  /// [addTodo] this function helps to add to-do
  Future<void> addToDo({
    required BuildContext context,
    required String addressValue,
    required String todo,
  }) async {
    try {
      addTodoLoadingState = true;
      notifyListeners();
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
              parameters: [EthereumAddress.fromHex(addressValue), todo]),
          chainId: 4);
      await Future.delayed(
        const Duration(seconds: 5),
      );
      await getToDoList(name: "getTodos", addressValue: addressValue);
      addTodoLoadingState = false;
      notifyListeners();
    } catch (e) {
      addTodoLoadingState = false;
      notifyListeners();
      rethrow;
    }
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

  /// [getAllTodoListLoadingState] this variable track the loading state of [getToDoList]
  bool getAllTodoListLoadingState = true;

  /// [todoListPublic] this data list hold all retrieved TO-DO list
  List<dynamic> todoListPublic = [];

  /// [decodedTodoList] this list hold all decoded TO-DO
  List<TodoModel> decodedTodoList = [];

  /// [getToDoList] this function helps to fetch all todos based on user address
  Future<void> getToDoList({
    required String name,
    required String addressValue,
  }) async {
    try {
      getAllTodoListLoadingState = true;
      notifyListeners();
      List<dynamic> todoList =
          await callFunction(name: name, addressValue: addressValue);
      log(todoList.toString());
      todoListPublic = todoList;
      if (todoListPublic.isNotEmpty && todoListPublic[0].isNotEmpty) {
        for (int i = 0; i < todoListPublic[0].length; i++) {
          decodedTodoList.add(TodoModel(
              isCompleted: todoListPublic[0][i][1].toString() == "true",
              todoName: todoListPublic[0][i][0]));
        }
      }
      getAllTodoListLoadingState = false;
      notifyListeners();
    } catch (e) {
      getAllTodoListLoadingState = false;
      notifyListeners();
      rethrow;
    }
  }
}
