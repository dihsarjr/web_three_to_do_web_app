import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_3_t0_do_web_app/web_three/home/provider/home_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data = "";

  @override
  void initState() {
    context.read<HomeProvider>().getContract();

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Consumer<HomeProvider>(builder: (context, snapshot, _) {
        return Center(
          child: Text(snapshot.address),
        );
      }),
    );
  }
}
