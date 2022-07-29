import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String address;
  const Home({Key? key, required this.address}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data = "";
  bool load = false;

  @override
  void initState() {
    // context.read<HomeProvider>().getContract().then(
    //   (value) {
    //     context.read<HomeProvider>().getToDoList(
    //           name: "getTodos",
    //           addressValue: widget.address,
    //         );
    //   },
    // );

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "TO-DO",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Row(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Scrollbar(
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              Checkbox(value: i == 1, onChanged: (v) {}),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text("TEST TO-DO"),
                              )
                            ],
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    },
                    itemCount: 100,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              )),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'TO-DO',
                      labelText: 'TO-DO',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: SizedBox(
                          height: 50, child: Center(child: Text("ADD TO-DO"))))
                ],
              ),
            ),
          ),
        ],
      ),
      // body: Consumer<HomeProvider>(
      //   builder: (context, snapshot, _) {
      //     return Center(
      //       child: Material(
      //         color: Colors.transparent,
      //         child: InkWell(
      //           onTap: () async {
      //             setState(() {
      //               load = true;
      //             });
      //             await snapshot.addToDo(
      //                 context: context, addressValue: widget.address);
      //             await context.read<HomeProvider>().getToDoList(
      //                   name: "getTodos",
      //                   addressValue: widget.address,
      //                 );
      //             setState(() {
      //               load = false;
      //             });
      //           },
      //           child: load
      //               ? const CircularProgressIndicator()
      //               : Text(
      //                   snapshot.address + snapshot.todoListPublic.toString()),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
