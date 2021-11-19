import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Pending extends StatefulWidget {
  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  List _todos = [];

  void initState() {

    super.initState();
    _completedItems();
  }

  _completedItems() async {
    _todos = await Hive.box("mytodo") as List<dynamic>;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber,
        title: Text("Pending Notes"),
      ),
      body: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            final todo = _todos[index];

            return Card(
              elevation: 15,
              color: Colors.amber,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todo.title!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                              Text(
                                todo.title!,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                ],
              ),
            );
          }),
    );
  }
}
