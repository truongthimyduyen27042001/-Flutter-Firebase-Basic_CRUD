import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_crud/list_page.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  late DateTime birthDate = DateTime(2001, 24, 7); // instance of DateTime
  late String birthDateInString = "";
  Future addUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('users');
    print(_nameController.text.toString());
    await docUser.add({
      "username": _nameController.text,
      "age": _ageController.text,
      "birthday": birthDate
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Listscreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Name'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Age'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text("Choose your birthday: "),
                    SizedBox(width: 20),
                    GestureDetector(
                        child: new Icon(Icons.calendar_today),
                        onTap: () async {
                          final datePick = await showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime(1900),
                              lastDate: new DateTime(2100));
                          if (datePick != null && datePick != birthDate) {
                            setState(() {
                              birthDate = datePick;
                              isDateSelected = true;
                              birthDateInString =
                                  "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                            });
                            print('AAAA');
                            print(birthDateInString);
                          }
                        }),
                    SizedBox(width: 10),
                    Text(isDateSelected ? "$birthDateInString" : initValue),
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: GestureDetector(
                    onTap: () {
                      addUser(name: "as");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "CREATE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
