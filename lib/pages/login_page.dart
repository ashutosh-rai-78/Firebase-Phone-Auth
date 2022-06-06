import 'package:flutter/material.dart';

enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET }

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  TextEditingController getPhoneNo = TextEditingController();
  TextEditingController getOTP = TextEditingController();

  showMobilePhoneWidget(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Verify Your Phone Number",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: getPhoneNo,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              backgroundColor: Colors.transparent,
            ),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Enter Phone No.',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Generate OTP"))
        ],
      ),
    );
  }

  showOTPWidget(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Verify Your OTP",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: getPhoneNo,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              backgroundColor: Colors.transparent,
            ),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Enter Your OTP',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Verify"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET
          ? showMobilePhoneWidget(context)
          : showOTPWidget(context),
    );
  }
}
