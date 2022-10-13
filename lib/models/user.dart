class User {
  late String id;
  final String name;
  final int age;
  final DateTime birthday;

  User(
      {this.id = '',
      required this.name,
      required this.age,
      required this.birthday});
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'birthday': birthday, 'age': age};
  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      birthday: json['birthday']);
}
