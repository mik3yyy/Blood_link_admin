import 'package:blood_link_admin/auth/login_screen.dart';
import 'package:blood_link_admin/main_screens/Donor_manager/donor_manager.dart';
import 'package:blood_link_admin/main_screens/blood_banks/blood_bank_screen.dart';
import 'package:blood_link_admin/main_screens/dashboard/dashboard.dart';
import 'package:blood_link_admin/providers/auth_provider.dart';
import 'package:blood_link_admin/settings/constants.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});
  static String id = "/admin_screen";
  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    // Connect SideMenuController and PageController together
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    List<SideMenuItem> items = [
      SideMenuItem(
        title: 'Dashboard',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: Icon(Icons.grid_view_sharp),
        // badgeContent: Text(
        //   '3',
        //   style: TextStyle(color: Colors.white),
        // ),
      ),
      SideMenuItem(
        title: 'Blood Banks',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: Icon(Icons.house),
      ),
      SideMenuItem(
        title: 'Donor Manager',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: Icon(Icons.person),
      ),
      SideMenuItem(
        title: 'Sign Out',
        onTap: (index, _) {
          Navigator.pushReplacementNamed(context, LoginScreen.id)
              .then((value) => authProvider.clear());
        },
        icon: Icon(Icons.exit_to_app),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.grey.withOpacity(0.3),
        leading: Container(
          width: 500,
          // height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/admin/logo.png"),
            ],
          ),
        ),
        leadingWidth: 400,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10), child: Container()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              // Page controller to manage a PageView
              controller: sideMenu,
              // Will shows on top of all items, it can be a logo or a Title text
              // title: Image.asset('assets/images/easy_sidemenu.png'),
              // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
              footer: Text('demo'),
              // Notify when display mode changed
              onDisplayModeChanged: (mode) {
                print(mode);
              },
              // List of SideMenuItem to show them on SideMenu
              items: items,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  DashBoardScreen(),
                  BloodBankScreen(),
                  DonorManager(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
