# user_crud

A new Flutter project.


# firebase + flutter 


### Read 
final CollectionReference _users_ = FirebaseFirestore.instance.collect("users");
## Create 
await _users.add({"username": username, "age": age});


## Edit 
await _users.doc(userId).update({"username": username, "age": age});


## Delete 
await _users.doc(userId).delete();



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
