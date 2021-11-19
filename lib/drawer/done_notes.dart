// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:responsive_tpdo/reuse_widgets/todo_model.dart';
//
//
// class DoneNotes extends StatefulWidget {
//
//   @override
//   _DoneNotesState createState() => _DoneNotesState();
// }
//
// class _DoneNotesState extends State<DoneNotes> {
//   late String tit;
//   late String des;
//   bool? isCompletedd;
//   var todos = <TodoModel>[];
//   addingDoneNotes() {
//     for (var i = 0; i<=todos.length; i++) {
//       todos.add(TodoModel(title: tit[i],describe: des[i]));
//     };
//
//   }
//
//
//
//   void initState() {
//
//     super.initState();
//     addingDoneNotes();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.amber,
//         title: Text("Done Notes"),
//       ),
//       body: ListView.builder(
//           itemCount: todos.length,
//           itemBuilder: (context, index) {
//             final todo = todos[index];
//
//             return Card(
//               elevation: 15,
//               color: Colors.amber,
//               shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(4),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 tit,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w900),
//                               ),
//                               Text(
//                               des,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w900),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // const SizedBox(
//                   //   height: 8,
//                   // ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
