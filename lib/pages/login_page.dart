
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth/pages/home_page.dart';
import 'package:flutter/material.dart';

enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;

  TextEditingController getPhoneNo = TextEditingController();

  TextEditingController getOTP = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationID = "";

  signInWithPhoneAuthCred(PhoneAuthCredential credential) async {
    final authCred = await auth.signInWithCredential(credential);

    try {
      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You are successfully Logged In")));
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

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
          ElevatedButton(
              onPressed: () async {
                await auth.verifyPhoneNumber(
                  phoneNumber: '+91${getPhoneNo.text}',
                  verificationCompleted:
                      (PhoneAuthCredential credential) async {
                    // await auth.signInWithCredential(credential);
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    if (e.code == 'invalid-phone-number') {
                      print('The provided phone number is not valid.');
                    }
                  },
                  codeSent: (String verificationId, int? resendToken) async {

                    setState(() {
                      currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
                      this.verificationID = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: const Text("Generate OTP"))
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
            controller: getOTP,
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
          ElevatedButton(
              onPressed: () {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationID, smsCode: getOTP.text);

                signInWithPhoneAuthCred(credential);

                // Sign the user in (or link) with the credential
              },
              child: Text("Verify"))
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
