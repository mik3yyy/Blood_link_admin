import 'package:blood_link_admin/auth/login_function.dart';
import 'package:blood_link_admin/global_comonents/custom_button.dart';
import 'package:blood_link_admin/global_comonents/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  bool obscuretext = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('LOGO'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: CustomTextField(
                      prefix: Icon(Icons.email_outlined),
                      controller: emailController,
                      hintText: "Enter Email",
                      onChange: () {
                        setState(() {});
                      }),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: CustomTextField(
                    controller: passwordController,
                    obscureText: obscuretext,
                    hintText: "Chinedum12#",
                    onChange: () {
                      setState(() {});
                    },
                    prefix: Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscuretext = !obscuretext;
                        });
                      },
                      icon: obscuretext
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                CustomButton(
                  loading: loading,
                  width: MediaQuery.sizeOf(context).width * .3,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    await LoginFunction.Login(
                        email: emailController.text,
                        password: passwordController.text,
                        scaffoldKey: scaffoldKey,
                        context: context);
                    setState(() {
                      loading = false;
                    });
                  },
                  title: "Login",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
