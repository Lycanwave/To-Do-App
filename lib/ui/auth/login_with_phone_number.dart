import 'package:firebase/ui/auth/verify_code.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final _phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
              ),
            ),
            SizedBox(height: 80),
            RoundButton(
                title: "Login",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  auth.verifyPhoneNumber(
                    phoneNumber: _phoneNumberController.text.toString(),
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                    verificationId: verificationId,
                                  )));
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
