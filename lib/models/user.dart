class User{
  final int id;
  final String name;
  final String phone;
  final String password;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
  });

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "phone" : phone,
      "password" : password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, phone: $phone, password: $password}';
  }
}