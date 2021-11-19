import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsive_tpdo/main.dart';
import 'package:responsive_tpdo/reuse_widgets/todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Search extends SearchDelegate<TodoModel> {
  Search({required this.searchD});

   List<TodoModel> searchD = [];



  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),

      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    List<TodoModel> filterName =
    searchD.where((element) => element.title!.startsWith(query)).toList();
    return ListView.builder(
        itemCount: query == "" ? searchD.length : filterName.length,
        itemBuilder: (context, index) {
          final todo = filterName[index];

          return query == ""
              ? Text(
            todo.title![index],
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900),
          )
              : Container(
            child: Text(
              filterName.length.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(searchD);

    print(query);
    List<TodoModel> filterName =
    searchD.where((element) => element.title!.contains(query)).toList();

    return ListView.builder(
        itemCount: filterName.length,
        itemBuilder: (context, index) {
          final todo = filterName[index];

          return Container(
            padding: EdgeInsets.all(10),
            child: Card( elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                todo.title!,
                textAlign: TextAlign.left,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          );
        });
  }
}

