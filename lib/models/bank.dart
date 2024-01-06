import 'package:hive/hive.dart';

class BloodBank extends HiveObject {
  final String bankName;

  final String bankId;

  final String latitude;

  final String longitude;

  final String address;

  final String email;

  final String password;

  // Constructor
  BloodBank({
    required this.bankName,
    required this.bankId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.email,
    required this.password,
  });

  // Convert a BloodBank into a Map
  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'bankId': bankId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'email': email,
      'password': password,
    };
  }

  // Create a BloodBank from a map
  factory BloodBank.fromMap(Map<String, dynamic> map) {
    return BloodBank(
      bankName: map['bankName'],
      bankId: map['bankId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Implement toString for easier debugging
  @override
  String toString() {
    return 'BloodBank(bankName: $bankName, bankId: $bankId, latitude: $latitude, longitude: $longitude, address: $address, email: $email, password: $password)';
  }
}
