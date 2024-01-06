import 'package:blood_link_admin/global_comonents/custom_button.dart';
import 'package:blood_link_admin/global_comonents/custom_messageHandler.dart';
import 'package:blood_link_admin/global_comonents/custom_textfield.dart';
import 'package:blood_link_admin/main_screens/blood_banks/blood_bank_function.dart';
import 'package:blood_link_admin/models/bank.dart';

import 'package:blood_link_admin/settings/constants.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:uuid/uuid.dart';

import '../../settings/google.dart';

class UploadBloodBanl extends StatefulWidget {
  const UploadBloodBanl({super.key});

  @override
  State<UploadBloodBanl> createState() => _UploadBloodBanlState();
}

class _UploadBloodBanlState extends State<UploadBloodBanl> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  bool obscuretext = true;
  bool obscuretext2 = true;
  bool loading = false;
  String lat = '';
  String long = '';
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Blood Bank",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "To proceed, we require the following information.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Constants.gap(height: 20),
              const Text(
                "Blood Bank Names",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: "Med Lab",
                onChange: () {
                  setState(() {});
                },
              ),
              Constants.gap(height: 20),
              const Text(
                "Email",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: "example@gmail.com",
                onChange: () {
                  setState(() {});
                },
                prefix: Icon(Icons.email_outlined),
              ),
              Constants.gap(height: 20),
              const Text(
                "Address",
              ),
              const SizedBox(
                height: 5,
              ),
              // FlutterGooglePlacesWeb(
              //   required: true,
              //   apiKey: Google.apikey,
              //   // proxyURL:
              //   //     'https://github.com/Rob--W/cors-anywhere#demo-server', //'https://cors-anywhere.herokuapp.com/',
              //   components: 'country:us',
              // ),
              CustomTextField(
                controller: controller,
                hintText: "Hon saheed bankole",
                onChange: () {
                  setState(() {});
                },
                prefix: Icon(Icons.my_location),
              ),
              // GooglePlacesAutoCompleteTextFormField(
              //     textEditingController: controller,
              //     googleAPIKey: Google.apikey,
              //     proxyURL:
              //         "https://cors-anywhere.herokuapp.com/", // only needed if you build for the web
              //     debounceTime: 400, // defaults to 600 ms,
              //     countries: [
              //       "ng"
              //     ], // optional, by default the list is empty (no restrictions)
              //     isLatLngRequired:
              //         true, // if you require the coordinates from the place details
              //     getPlaceDetailWithLatLng: (prediction) {
              //       // this method will return latlng with place detail
              //       print("placeDetails" + prediction.lng.toString());
              //     }, // this callback is called when isLatLngRequired is true
              //     itmClick: (prediction) {
              //       controller.text = prediction.description ?? "";
              //       controller.selection = TextSelection.fromPosition(
              //           TextPosition(offset: prediction.description!.length));
              //     }),
              Constants.gap(height: 20),
              const Text(
                "Password",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _passwordController,
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
              Constants.gap(height: 20),
              const Text(
                "Confirm Password",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _cpasswordController,
                obscureText: obscuretext2,
                hintText: "Chinedum12#",
                onChange: () {
                  setState(() {});
                },
                prefix: Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscuretext2 = !obscuretext2;
                    });
                  },
                  icon: obscuretext2
                      ? Icon(Icons.visibility_outlined)
                      : Icon(Icons.visibility_off_outlined),
                ),
              ),
              Constants.gap(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                    enable: _emailController.text.isNotEmpty &&
                        _nameController.text.isNotEmpty &&
                        controller.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _cpasswordController.text.isNotEmpty,
                    loading: loading,
                    onTap: () async {
                      if (_cpasswordController.text ==
                          _passwordController.text) {
                        setState(() {
                          loading = true;
                        });

                        // geo.Location location =
                        //     await BloodBankFunction.getAddressLocation(
                        //         controller.text);
                        lat = "6.8923";
                        long = "3.7242";
                        String id = const Uuid().v4();
                        BloodBank bloodBank = BloodBank(
                          bankName: _nameController.text,
                          bankId: id,
                          latitude: lat,
                          longitude: long,
                          address: controller.text,
                          email: _emailController.text,
                          password: _cpasswordController.text,
                        );
                        await BloodBankFunction.signupBloodBank(
                          bloodBank: bloodBank,
                          context: context,
                          scaffoldKey: scaffoldKey,
                        );
                      } else {
                        MyMessageHandler.showSnackBar(
                            scaffoldKey, "Confirm Password");
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    title: "Create Blood Bank",
                    width: 200,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
