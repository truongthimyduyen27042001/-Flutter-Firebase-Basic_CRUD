import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_crud/edit_page.dart';

import 'models/user.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            // return Container(
            //   child: Row(
            //     children: [
            //       Text(data['age'].toString()),
            //       Text(data['username'].toString())
            //     ],
            //   ),
            // );
            return StudentWidget(
              name: data['username'].toString(),
              age: data['age'].toString(),
            );
          }).toList(),
        );
      },
    );
  }
}

class StudentWidget extends StatelessWidget {
  const StudentWidget({
    Key? key,
    required this.age,
    required this.name,
  }) : super(key: key);
  final String age;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //age
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Center(
                child: Text(
                  age,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ), //infor
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "2022-01-21",
                    style: TextStyle(color: Colors.black38, fontSize: 15),
                  )
                  //birthday
                ],
              ),
            ),

            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    final docUser = FirebaseFirestore.instance
                        .collection("users")
                        .doc("xAIiXKfrhY5m1GD6c9dV");
                    docUser.update({"username": "new name"});
                  },
                  child: Text('Edit'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    final docUser = FirebaseFirestore.instance
                        .collection("users")
                        .doc("12sdsds");
                    docUser.delete();
                  },
                  child: Text('Delete'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
