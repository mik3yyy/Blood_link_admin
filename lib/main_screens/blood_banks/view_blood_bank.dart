import 'package:blood_link_admin/models/bloodType.dart';
import 'package:blood_link_admin/main_screens/blood_banks/blood_bank_screen.dart';
import 'package:blood_link_admin/models/bank.dart';
import 'package:blood_link_admin/settings/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewBloodBank extends StatefulWidget {
  const ViewBloodBank({super.key, required this.bank});
  final BloodBank bank;

  @override
  State<ViewBloodBank> createState() => _ViewBloodBankState();
}

class _ViewBloodBankState extends State<ViewBloodBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Constants.grey)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bank.bankName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        widget.bank.address,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Constants.grey,
                        ),
                      ),
                      Text(
                        widget.bank.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Constants.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // child: ,
            ),
            Constants.gap(height: 20),
            Expanded(
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Constants.gap(height: 20),
                    InventoryScreen(
                      bankId: widget.bank.bankId,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  final String bankId; // ID of the bank to fetch inventory for

  InventoryScreen({Key? key, required this.bankId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('inventory')
          .doc(bankId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No inventory found for bank ID: $bankId'));
        }

        // Extract the blood types from the inventory document
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        List<BloodType> bloodTypes = [
          BloodType.fromMap(data['APositive']),
          BloodType.fromMap(data['ANegative']),
          BloodType.fromMap(data['BPositive']),
          BloodType.fromMap(data['BNegative']),
          BloodType.fromMap(data['ABPositive']),
          BloodType.fromMap(data['ABNegative']),
          BloodType.fromMap(data['OPositive']),
          BloodType.fromMap(data['ONegative']),
        ];

        return Container(
          height: 600,
          width: 4000,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns in the grid
                crossAxisSpacing: 10, // Horizontal space between items
                mainAxisSpacing: 10, // Vertical space between items
                mainAxisExtent: 100),
            itemCount: bloodTypes.length,
            itemBuilder: (context, index) {
              // Get the specific BloodType object
              BloodType bloodType = bloodTypes[index];

              // Build a card for each blood type
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Constants.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Constants.gap(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: 50,
                            child: Center(
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: bloodType.pints < 10
                                    ? Colors.red
                                    : bloodType.pints < 20
                                        ? Colors.yellow
                                        : Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bloodType.pints
                                .toString(), // Blood type name, e.g., 'A+'
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Constants.black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${bloodType.name} (${bloodType.symbol})', // Number of pints available
                            style: TextStyle(
                              fontSize: 14,
                              color: Constants.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
