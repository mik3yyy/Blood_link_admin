import 'package:blood_link_admin/global_comonents/custom_messageHandler.dart';
import 'package:blood_link_admin/models/bank.dart';
import 'package:blood_link_admin/models/bloodType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

class BloodBankFunction {
  static Future<void> signupBloodBank({
    required BloodBank bloodBank,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    // var uuid = Uuid();
    // String bankId = uuid.v4();

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference banks = firestore.collection('bank');
    CollectionReference inventories = firestore.collection('inventory');

    // Step 1: Upload Blood Bank to Bank collection
    await banks.doc(bloodBank.bankId).set(bloodBank.toMap());

    // Step 2: Create a new inventory doc in the inventory collection
    await inventories.doc(bloodBank.bankId).set({
      'bankId': bloodBank.bankId,
      'APositive':
          BloodType(symbol: 'A+', name: 'APositive', pints: 0, unit: 'units')
              .toMap(),
      'ANegative':
          BloodType(symbol: 'A-', name: 'ANegative', pints: 0, unit: 'units')
              .toMap(),
      'BPositive':
          BloodType(symbol: 'B+', name: 'BPositive', pints: 0, unit: 'units')
              .toMap(),
      'BNegative':
          BloodType(symbol: 'B-', name: 'BNegative', pints: 0, unit: 'units')
              .toMap(),
      'ABPositive':
          BloodType(symbol: 'AB+', name: 'ABPositive', pints: 0, unit: 'units')
              .toMap(),
      'ABNegative':
          BloodType(symbol: 'AB-', name: 'ABNegative', pints: 0, unit: 'units')
              .toMap(),
      'OPositive':
          BloodType(symbol: 'O+', name: 'OPositive', pints: 0, unit: 'units')
              .toMap(),
      'ONegative':
          BloodType(symbol: 'O-', name: 'ONegative', pints: 0, unit: 'units')
              .toMap(),
    });
    MyMessageHandler.showSnackBar(scaffoldKey, "Successful ");
  }

  static Future<geo.Location> getAddressLocation(String address) async {
    try {
      List<geo.Location> locations = await geo.locationFromAddress(address);

      if (locations.isNotEmpty) {
        // Taking the first result from the list of locations, which is usually the most accurate/relevant.
        return locations.first;
      } else {
        throw Exception('No location found for the given address.');
      }
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }
}
