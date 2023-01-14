import 'package:flutter/material.dart';
import 'package:flutter2/khampha.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void showFaileMessage() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
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

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 36, left: 15),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => KhamPha()));
                      },
                      icon: Icon(Icons.chevron_left),
                      color: Color.fromRGBO(221, 221, 221, 1),
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.03),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 36, left: 30),
                    child: Center(
                      child: Text(
                        "Đăng Nhập",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black12,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            )),
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Vui lòng nhập Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-z0-9A-Z.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Vui lòng nhập Email hợp lệ");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            )),
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
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      style:
                      ElevatedButton.styleFrom(primary: Colors.blueGrey[700],
    ),
                      child: SizedBox(
                        width: 280,
                        height: 50,
                        child: Center(
                          child: Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

          ),
        );
  }
}
