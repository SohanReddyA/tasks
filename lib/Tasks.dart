

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart%20';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late User loggedInUser;
class Tasks extends StatefulWidget {
  static const String id = 'Tasks';
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  void getCurrentUser() {
    try{
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  // void getTasks() async
  // {
  //   final tasks = await _firestore.collection('tasks').get();
  //   for (var t in tasks.docs){
  //     print(t.data());
  //   }
  // }

  void taskStream() async{
    await for(var snapshot in _firestore.collection('tasks').snapshots()){
      for (var t in snapshot.docs) {

      }
    }
  }
  TextEditingController timeinput = TextEditingController();
  String task="";
  @override
  void initState() {
    timeinput.text = "";
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(75, 75, 75, 1),
        body:
        // SafeArea(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: const Size.fromHeight(40)),
                child: Text("+"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Add Task'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    onChanged: (value){
                                      task=value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                    ),
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    onTap: () async {
                                      TimeOfDay? pickedTime = await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );
                                      if (pickedTime != null) {
                                        print(pickedTime.format(
                                            context));
                                        DateTime parsedTime = DateFormat.jm().parse(
                                            pickedTime.format(context).toString());

                                        print(
                                            parsedTime);
                                        String formattedTime = DateFormat('HH:mm:ss')
                                            .format(parsedTime);
                                        print(formattedTime);

                                        setState(() {
                                          timeinput.text =
                                              formattedTime;
                                        });
                                      } else {
                                        print("Time is not selected");
                                      }
                                    },
                                    controller: timeinput,
                                    decoration: InputDecoration(
                                        disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                        contentPadding: EdgeInsets.only(top: 0.0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  _firestore.collection('tasks').add({
                                    'task':task,
                                    'time':timeinput.text,
                                    'user':loggedInUser.email,
                                  });
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                },
              ),
              // StreamBuilder<QuerySnapshot>(
              //   stream: _firestore.collection('tasks').snapshots(),
              //   builder: (context, snapshot),
              // ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue[300],
          onTap: (int a) {
            // getTasks();
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/icons8-combo-chart-30.png'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/icons8-lock-30.png'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/icons8-clock-50.png'),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}




//
// class TaskStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('Task').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlueAccent,
//             ),
//           );
//         }
//         final Task = snapshot.data?.docs;
//         List<TaskBubble> TaskBubbles = [];
//         for (var T in Task) {
//           final TaskText = Task.data['text'];
//           final Taskender = Task.data['sender'];
//
//           final currentUser = loggedInUser.email;
//
//           final TaskBubble = TaskBubble(
//             sender: Taskender,
//             text: TaskText,
//             isMe: currentUser == Taskender,
//           );
//
//           TaskBubbles.add(TaskBubble);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: TaskBubbles,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class TaskBubble extends StatelessWidget {
//   TaskBubble({this.sender, this.text, this.isMe});
//
//   final String sender;
//   final String text;
//   final bool isMe;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment:
//         isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: Colors.black54,
//             ),
//           ),
//           Material(
//             borderRadius: isMe
//                 ? BorderRadius.only(
//                 topLeft: Radius.circular(30.0),
//                 bottomLeft: Radius.circular(30.0),
//                 bottomRight: Radius.circular(30.0))
//                 : BorderRadius.only(
//               bottomLeft: Radius.circular(30.0),
//               bottomRight: Radius.circular(30.0),
//               topRight: Radius.circular(30.0),
//             ),
//             elevation: 5.0,
//             color: isMe ? Colors.lightBlueAccent : Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: isMe ? Colors.white : Colors.black54,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
