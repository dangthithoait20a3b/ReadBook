import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/khampha.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  void showFaileMessage() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text("Login"),
              content: Text("Login failed"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, "OK");
                    },
                    child: Text("OK"))
              ],
            ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 36, left: 24),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KhamPha()));
                    },
                    icon: Icon(Icons.chevron_left),
                    color: Color.fromRGBO(221, 221, 221, 1),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.03),
                      borderRadius: BorderRadius.circular(50)
                  ),
                ),
                Container(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 36, left: 70),
                      child: Image.asset(
                        'images/logo.png',
                        height: 33,
                        width: 108,
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 47),
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 22, left: 102),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "If You Need Any Support",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(225, 225, 225, 1)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Click Here",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(56, 180, 50, 1)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 29, top: 18),
                      width: 334,
                      height: 80,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(167, 167, 167, 0.6)),
                            ),
                            style: TextStyle(color: Colors.white),
                            controller: fullnameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Vui lòng nhập tên");
                              }
                            },
                            onSaved: (value) {
                              fullnameController.text = value!;
                            },
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              width: 1),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 29, top: 18),
                      width: 334,
                      height: 80,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(167, 167, 167, 0.6)),
                            ),
                            style: TextStyle(color: Colors.white),
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Vui lòng nhập Email");
                              }
                              if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-z0-9A-Z.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Vui lòng nhập Email hợp lệ");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              width: 1),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 29, top: 18),
                      width: 334,
                      height: 80,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(167, 167, 167, 0.6)),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                )),
                            style: TextStyle(color: Colors.white),
                            controller: passwordController,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Mật khẩu bắt buộc để đăng nhập");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Mật khẩu không hợp lệ");
                              }
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            obscureText: _obscureText,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              width: 1),
                          borderRadius: BorderRadius.circular(30)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),

            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 137),
                      child: Image.asset('images/logo_google.png'),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 59),
                      child: Image.asset('images/logo_apple.png'),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 55,
            ),
            Container(
              margin: EdgeInsets.only(left: 98),
              child: Center(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              'Do You Have An Account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color.fromRGBO(219, 219, 219, 1)),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(40, 140, 233, 1)),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
