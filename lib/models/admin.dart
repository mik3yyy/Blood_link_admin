class Admin {
  String name;
  String email;
  String password;

  Admin({
    required this.name,
    required this.email,
    required this.password,
  });

  // Converts an Admin object into a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password':
          password, // Note: Storing passwords in plain text is a security risk
    };
  }

  // Creates an Admin object from a map
  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  String toString() {
    return 'Admin(name: $name, email: $email, password: $password)';
  }
}
