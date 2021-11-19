import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_tpdo/drawer/done_notes.dart';
import 'package:responsive_tpdo/drawer/pending.dart';
import 'package:responsive_tpdo/main.dart';
import 'package:responsive_tpdo/reuse_widgets/search_delegate.dart';
import 'package:responsive_tpdo/reuse_widgets/todo_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum TodoFilter { ALL, DoneNotes, Pending }

class _MyHomePageState extends State<MyHomePage> {
  late String? query;
  late Box<TodoModel> todoList;
  List<TodoModel> mySearchDelegate = [];
  final titlecontrller = TextEditingController();
  final desccontrller = TextEditingController();

  TodoFilter filter = TodoFilter.ALL;

  searchMethod() {
    for (var i = 0; i <= todoList.length; i++) {
      String title = '';
      // mySearchDelegate.add(TodoModel(title: title));
      mySearchDelegate = title.isEmpty ? todoList.values.toList() //
      : todoList.values.where((c) => c.title!.toLowerCase().contains(title)).toList();

    }
    print(mySearchDelegate);
    return mySearchDelegate;
  }

  @override
  void initState() {
    todoList = Hive.box<TodoModel>(boxNameDB);
    searchMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   elevation: 15,
      //   child: Material(
      //     color: Colors.amberAccent,
      //     child: Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 20),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             ElevatedButton.icon(
      //                 onPressed: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => DoneNotes()));
      //                 },
      //                 icon: const Icon(Icons.clear_all_outlined),
      //                 label: const Text("All Notes")),
      //             ElevatedButton.icon(
      //                 onPressed: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => DoneNotes()));
      //                 },
      //                 icon: const Icon(Icons.done_outline_outlined),
      //                 label: const Text("Done Notes")),
      //             ElevatedButton.icon(
      //                 onPressed: () {
      //                   Navigator.push(context,
      //                       MaterialPageRoute(builder: (context) => Pending()));
      //                 },
      //                 icon: const Icon(Icons.pending),
      //                 label: const Text("Pending"))
      //           ],
      //         )),
      //   ),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Notes"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: Search(searchD: mySearchDelegate));
              },
              icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
              if (value == "All") {
                setState(() {
                  filter = TodoFilter.ALL;
                  print(filter);
                });
              } else if (value == "Done Notes") {
                setState(() {
                  filter = TodoFilter.DoneNotes;
                  print("2222" + "$filter");
                });
              } else {
                setState(() {
                  filter = TodoFilter.Pending;
                  print(filter);
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return ["All", "Done Notes", "Pending"].map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: todoList.listenable(),
        builder: (context, Box<TodoModel> todos, _) {
          List<int> keys;
          print(filter);
          if (filter == TodoFilter.ALL) {
            keys = todos.keys.cast<int>().toList();
          } else if (filter == TodoFilter.DoneNotes) {
            keys = todos.keys
                .cast<int>()
                .where((key) => todos.get(key)!.completed == true)
                .toList();
            print(keys);
            print("مرحبا من DoneNotes " + "$keys");
          } else {
            keys = todos.keys
                .cast<int>()
                .where((key) => todos.get(key)!.completed == false)
                .toList();
            print("مرحبا من else " + "$keys");
          }
          // List<int> keys = todos.keys.cast<int>().toList();

          return Container(
            child: ListView.separated(
                separatorBuilder: (_, index) => const Divider(
                      color: Colors.black87,
                      thickness: 5,
                    ),
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  final key = keys[index];
                  final TodoModel? todo = todos.get(key);

                  return SingleChildScrollView(
                    child: ListTile(
                      onTap: () async {
                        return await showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.all(15),
                                              child: TextFormField(
                                                // TextEditingController.clear()
                                                controller: titlecontrller,
                                                style: const TextStyle(
                                                    fontSize: 25),
                                                decoration: InputDecoration(
                                                    labelText: "Title",
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                              )),
                                          Container(
                                              margin: const EdgeInsets.all(15),
                                              child: TextFormField(
                                                controller: desccontrller,
                                                maxLines: null,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    labelText: "Description",
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.all(2.5),
                                                  width: 80,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  StadiumBorder()),
                                                      onPressed: () {
                                                        titlecontrller.clear();
                                                        desccontrller.clear();

                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ))),
                                              Container(
                                                  margin: EdgeInsets.all(2.5),
                                                  width: 80,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  StadiumBorder()),
                                                      onPressed: () async {
                                                        if (desccontrller
                                                            .text.isNotEmpty) {
                                                          final String
                                                              tit_Update =
                                                              titlecontrller
                                                                  .text;
                                                          final String
                                                              de_Update =
                                                              desccontrller
                                                                  .text;

                                                          todoList.putAt(
                                                              index,
                                                              TodoModel(
                                                                  title:
                                                                      tit_Update,
                                                                  describe:
                                                                      de_Update));
                                                          Navigator.pop(
                                                              context);
                                                          titlecontrller
                                                              .clear();
                                                          desccontrller.clear();
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                      'Please Complete The Process'),
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2)));
                                                        }
                                                      },
                                                      child: const Text(
                                                        "Update",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ))),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            });
                      },
                      title: Text(
                        todo!.title!,
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle:
                          Text(todo.describe!, style: TextStyle(fontSize: 18)),
                      leading: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          children: [
                            // InkWell(onTap: (){
                            //   searchMethod();
                            // },
                            //     child: Text("gggg")),
                            const SizedBox(
                              width: 5,
                            ),
                            Card(
                                color: Colors.white70,
                                elevation: 50,
                                child: Checkbox(
                                    value: todo.completed ?? false,
                                    onChanged: (val) {
                                      TodoModel compTodo = TodoModel(
                                          completed: todo.completed,
                                          title: todo.title,
                                          describe: todo.describe);
                                      todoList.put(key, compTodo);
                                      setState(() {
                                        if (compTodo.completed == true) {
                                          compTodo.completed = val;
                                        } else {
                                          compTodo.completed = val;
                                        }
                                      });
                                    })),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            todoList.delete(key);
                            print(key);
                          },
                          icon: const Icon(Icons.delete)),

//                   leading: Card(
//                     elevation: 30,
//                     child:
//
//                     Checkbox(
//                       value: isCompleted,
//                       onChanged: (value) {
//                       setState((){
//                         String? myTitle = todos.keys.toList()[index];
//
//                         print("aasas++++" + myTitle!);
// // myTitle.isCompleted
//                         // .iscompleted = value;
//
//
//
//                         });
//                       },
//                     ),
//
//
//                   ),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(15),
                                child: TextFormField(
                                  // TextEditingController.clear()
                                  controller: titlecontrller,
                                  style: const TextStyle(fontSize: 25),
                                  decoration: InputDecoration(
                                      labelText: "Title",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                )),
                            Container(
                                margin: const EdgeInsets.all(15),
                                child: TextFormField(
                                  controller: desccontrller,
                                  maxLines: null,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                      labelText: "Description",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    width: 100,
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                        onPressed: () {
                                          titlecontrller.clear();
                                          desccontrller.clear();
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(fontSize: 20),
                                        ))),
                                Container(
                                    margin: EdgeInsets.all(10),
                                    width: 100,
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder()),
                                        onPressed: () {
                                          if (titlecontrller.text.isNotEmpty &&
                                              desccontrller.text.isNotEmpty) {
                                            final String mytitle =
                                                titlecontrller.text;
                                            final String mydescription =
                                                desccontrller.text;
                                            final dayingTime =
                                                DateTime.now().day;

                                            TodoModel mytodos = TodoModel(
                                                title: mytitle,
                                                describe: mydescription,
                                                completed: false);

                                            todoList.put(todoList.values.length,
                                                mytodos);

                                            titlecontrller.clear();
                                            desccontrller.clear();
                                            Navigator.pop(context);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        'Please Complete The Process'),
                                                    duration:
                                                        Duration(seconds: 2)));
                                          }
                                        },
                                        child: const Text(
                                          "Done",
                                          style: TextStyle(fontSize: 25),
                                        )))
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              });
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
