import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/home.dart';
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
  final TextEditingController confirmPasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login())), icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title: Text("Đăng Ký", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          color: Colors.black
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 100),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Tên',
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            )),
                        controller: fullnameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Vui lòng nhập tên");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-z0-9A-Z.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Vui lòng nhập tên hợp lệ");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullnameController.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Email',
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            )
                        ),
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
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Mật khẩu',
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
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Nhập lại mật khẩu',
                            fillColor: Colors.black12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            )),
                        controller: confirmPasswordController,
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
                          confirmPasswordController.text = value!;
                        },
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 30,
                        child: Icon(Icons.square, color: Colors.blueGrey[400],),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Điều khoản sử dụng ứng dụng",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.open_in_new),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        ).then((value) {
                          firestore.collection("user").add({
                            "fullname":fullnameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                            "uid": auth.currentUser!.uid
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));
                        }).onError((error, stackTrace) {
                          showFaileMessage();
                        });
                      },
                      color: Colors.blueGrey[700],
                      minWidth: 330,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: InkWell(
                  child: Text("Đã có tài khoản"),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
