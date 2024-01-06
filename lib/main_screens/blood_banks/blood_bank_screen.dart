import 'package:blood_link_admin/main_screens/blood_banks/upload_blood_bank_screen.dart';
import 'package:blood_link_admin/main_screens/blood_banks/view_blood_bank.dart';
import 'package:blood_link_admin/models/bank.dart';
import 'package:blood_link_admin/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BloodBankScreen extends StatefulWidget {
  const BloodBankScreen({super.key});

  @override
  State<BloodBankScreen> createState() => _BloodBankScreenState();
}

class _BloodBankScreenState extends State<BloodBankScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalBanksWidget(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadBloodBanl()));
                  },
                  child: Container(
                    height: 40,
                    width: 197,
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.darkPink),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Constants.darkPink,
                        ),
                        Text(
                          'Add Blood Bank',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Constants.darkPink,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
                    "Blood Banks",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Constants.gap(height: 20),
                  BanksGridScreen(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TotalBanksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Stream of documents in the 'Bank' collection
    Stream<QuerySnapshot> bankStream =
        FirebaseFirestore.instance.collection('bank').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: bankStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No data found'));
        }

        // Calculate the total number of banks
        int totalBanks = snapshot.data!.docs.length;

        // Display the total number of banks
        return Container(
            height: 82,
            width: 340,
            decoration: BoxDecoration(
              border: Border.all(color: Constants.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: 50,
                      child: Center(
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Color(0xFF72C8CC),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$totalBanks',
                      style: TextStyle(
                          color: Constants.darkPink,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Total Number of Blood banks ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Constants.grey,
                      ),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }
}

class BanksGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('bank').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No banks found.'));
        }

        // Build GridView
        return Container(
          height: MediaQuery.sizeOf(context).height * .5,
          width: double.infinity,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              crossAxisSpacing: 10, // Horizontal space between items
              mainAxisSpacing: 10, // Vertical space between items
              childAspectRatio: 2, // Aspect ratio of the cards
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Assume each document contains 'name' and 'address' fields
              var bank =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  BloodBank main = BloodBank.fromMap(bank);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewBloodBank(bank: main)));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Placeholder for bank logo
                        CircleAvatar(
                          radius: 30,
                          child: Center(
                            child: Icon(Icons.house),
                          ),
                          // backgroundImage: NetworkImage(
                          //     'url/to/your/bank/logo.jpg'), // Replace with actual image URL
                        ),
                        SizedBox(height: 8),
                        Text(
                          bank['bankName'], // Bank name
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.black,
                          ),
                        ),
                        Text(
                          bank['address'], // Bank address
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "", // Last updated date
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
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
