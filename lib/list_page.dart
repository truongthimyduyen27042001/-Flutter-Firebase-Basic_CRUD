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
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  return StudentWidget(
                    name: data['username'].toString(),
                    age: data['age'].toString(),
                    document: document,
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}

class StudentWidget extends StatelessWidget {
  StudentWidget({
    Key? key,
    required this.age,
    required this.name,
    required this.document,
  }) : super(key: key);
  final String age;
  final String name;
  final DocumentSnapshot document;
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();
  Future<void> _update() async {
    final docUser =
        FirebaseFirestore.instance.collection("users").doc(document.id);
    await docUser
        .update({"username": _nameController.text, "age": _ageController.text});
    print("hello world");
  }

  Future<void> delete() async {
    final docUser =
        FirebaseFirestore.instance.collection("users").doc(document.id);
    docUser.delete();
  }

  @override
  Widget build(BuildContext context) {
    //open update view
    Future<void> _showEdit([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        _nameController.text = "Le Tuann";
        _ageController.text = document['age'];
      }
      _nameController.text = document['username'];
      _ageController.text = document['age'].toString();
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(children: [
                TextField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: "Name", hintText: name),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: "Age"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    _update();
                  },
                )
              ]),
            );
          });
    }

    //delete
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      age,
                      style: TextStyle(fontSize: 14),
                    )
                  ]),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEdit();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete();
              },
            )
          ],
        ),
      ),
    );
  }
}
