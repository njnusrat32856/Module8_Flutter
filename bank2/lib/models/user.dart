class User {
  final int id;
  final String accountNumber;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String gender;
  final String address;
  final String mobileNo;
  final String nid;
  final String dob;
  final String image;
  final String accountType;
  final DateTime createDate;
  // final bool status;
  final double balance;
  // final bool isLock;
  // final String role;

  User({
    required this.id,
    required this.accountNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.address,
    required this.mobileNo,
    required this.nid,
    required this.dob,
    required this.image,
    required this.accountType,
    required this.createDate,
    // required this.status,
    required this.balance,
    // required this.isLock,
    // required this.role,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      accountNumber: json['accountNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      address: json['address'],
      mobileNo: json['mobileNo'],
      nid: json['nid'],
      dob: json['dob'],
      image: json['image'],
      accountType: json['accountType'],
      createDate: DateTime.parse(json['createDate']),
      // status: json['status'],
      balance: json['balance'],
      // isLock: json['isLock'],
      // role: json['role'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'address': address,
      'mobileNo': mobileNo,
      'nid': nid,
      'dob': dob,
      'image': image,
      'accountType': accountType,
      'createDate': createDate.toIso8601String(),
      // 'status': status,
      'balance': balance,
      // 'isLock': isLock,
      // 'role': role,
    };
  }
}
