import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Quên mật khẩu"),
        leading: IconButton(onPressed: (){},
            icon: Icon(Icons.keyboard_backspace)),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          hintText: 'Email',
                          fillColor: Colors.black12,
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          )),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(onPressed: () async{
                    var forgotEmail = emailController.text.trim();
                    try{
                      FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).then((value) => {
                        print("Email Sent!"),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()))
                      });
                    }on FirebaseAuthException catch(e){
                        print("Error $e");
                    }
                    },
                      child: Text("Forgot Password"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
