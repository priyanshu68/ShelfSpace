import 'package:bookshelf_virtual/authentication/loginPage.dart';
import 'package:bookshelf_virtual/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  TextEditingController otp = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

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
              "Verify OTP",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 250,
              height: 50,
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: otp,
                textAlign: TextAlign.center,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    hintText: "Enter the OTP",
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
                    String code = otp.text.trim();
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: LoginPage.verify, smsCode: code);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Homepage()));
                  },
                  child: Text("Verify OTP"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 210, 103, 228)),
                ))
          ],
        ),
      ),
    ));
  }
}
