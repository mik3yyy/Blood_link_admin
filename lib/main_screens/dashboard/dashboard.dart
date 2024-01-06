import 'package:blood_link_admin/global_comonents/custom_list_container.dart';
import 'package:blood_link_admin/settings/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Stream<QuerySnapshot> bankStream =
      FirebaseFirestore.instance.collection('bank').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // border: Border.all(color: Constants.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Constants.gap(height: 8),
                Text(
                  "Complete Overview of the Blood bank management system",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Constants.grey),
                ),
              ],
            ),
            Constants.gap(height: 20),
            Padding(
              padding:
                  EdgeInsets.only(right: MediaQuery.sizeOf(context).width * .2),
              child: Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: bankStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Expanded(
                          flex: 1,
                          child: Container(
                            height: 150,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Constants.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Constants.white,
                                ),
                                Text(
                                  "Total Blood Banks",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Constants.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${totalBanks}",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Constants.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                  Constants.gap(width: 50),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('donor')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Expanded(
                          flex: 1,
                          child: Container(
                            height: 150,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Constants.darkPink,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Constants.white,
                                ),
                                Text(
                                  "Total Donors",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Constants.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${totalBanks}",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Constants.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                  Constants.gap(width: 50),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 150,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.purple[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: Constants.white,
                            ),
                            Text(
                              "Blood Types",
                              style: TextStyle(
                                fontSize: 16,
                                color: Constants.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${8}",
                              style: TextStyle(
                                fontSize: 28,
                                color: Constants.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )),
                  Constants.gap(width: 50),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('campaigns')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Expanded(
                          flex: 1,
                          child: Container(
                            height: 150,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Constants.white,
                                ),
                                Text(
                                  "Total Campaigns",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Constants.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${totalBanks}",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Constants.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Constants.gap(height: 15),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('inventory')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No inventory found.'));
                        }

                        // Aggregate pints for each blood type
                        Map<String, int> bloodTypeCounts = {
                          'APositive': 0,
                          'ANegative': 0,
                          'BPositive': 0,
                          'BNegative': 0,
                          'ABPositive': 0,
                          'ABNegative': 0,
                          'OPositive': 0,
                          'ONegative': 0,
                        };

                        for (var doc in snapshot.data!.docs) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          bloodTypeCounts.keys.forEach((key) {
                            if (data[key] != null &&
                                data[key]['pints'] != null) {
                              bloodTypeCounts[key] = int.parse(
                                  (bloodTypeCounts[key]! + data[key]['pints'])
                                      .toString());
                            }
                          });
                        }

                        // Now, you can display the counts in your UI
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // Number of columns
                              crossAxisSpacing:
                                  80, // Horizontal space between items
                              mainAxisSpacing:
                                  10, // Vertical space between items
                              mainAxisExtent: 110,
                            ),
                            itemCount: bloodTypeCounts.length,
                            itemBuilder: (context, index) {
                              String bloodTypeKey =
                                  bloodTypeCounts.keys.elementAt(index);
                              return _buildBloodTypeCard(
                                  bloodTypeKey, bloodTypeCounts[bloodTypeKey]!);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBloodTypeCard(String bloodType, int pintCount) {
  // Define colors and icons for your cards based on blood type
  // For the example, a simple colored circle is used
  Color circleColor =
      Colors.blue; // Replace with logic for different colors per blood type

  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Constants.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: pintCount < 10
              ? Colors.red
              : pintCount < 20
                  ? Colors.yellow
                  : Colors.green,
          radius: 20.0,
          // Add icon or image for blood type if needed
        ),
        Constants.gap(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pintCount.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              bloodType,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    ),
  );
}
