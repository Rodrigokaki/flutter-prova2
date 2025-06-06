class User {
  int? id;
  String name;
  String surname;
  String email;
  String password;

  User({
    this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'] ?? '',
      email: map['email'],
      password: map['password'],
    );
  }
}
