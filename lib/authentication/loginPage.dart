import 'package:bookshelf_virtual/authentication/otpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String verify = "";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  //bool isLogin = false;
  TextEditingController phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/img/login.png"),
              ),
              SizedBox(height: 15),
              Text(
                "Login using OTP",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phone,
                  textAlign: TextAlign.center,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      hintText: "Enter Your Phone Number",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 149, 113, 170),
                      ),

                      //prefixIconColor: Colors.purple[500],
                      filled: true,
                      fillColor: Colors.purple[100],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 213, 213, 213))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 167, 130, 178)))),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      // print(phone);
                      String number = phone.text.trim();
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: number,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          LoginPage.verify = verificationId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => OtpPage()));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text("Send OTP"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 210, 103, 228)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
