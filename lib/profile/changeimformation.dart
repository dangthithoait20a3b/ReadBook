import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/Login/logged.dart';
import 'package:flutter2/khampha.dart';

class changeInformation extends StatefulWidget {
  const changeInformation({Key? key}) : super(key: key);

  @override
  State<changeInformation> createState() => _changeInformationState();
}

class _changeInformationState extends State<changeInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Thay đổi thông tin",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => logged()));
          },
          icon: Icon(Icons.chevron_left),
          color: Colors.black,
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
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("user")
                              .where("uid",
                                  isEqualTo: currentUser.currentUser!.uid)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  var data = snapshot.data!.docs[i];
                                  return TextField(
                                    controller: TextEditingController()
                                      ..text = data["email"],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                      filled: true,
                                        fillColor: Colors.black12,
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        )
                                    ),
                                  );
                                },
                              );
                            } else {
                              return TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Tên',
                                    fillColor: Colors.black12,
                                    prefixIcon: Icon(Icons.person_outline),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    )),
                                controller: fullnameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Vui lòng nhập tên");
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-z0-9A-Z.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Vui lòng nhập tên hợp lệ");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  fullnameController.text = value!;
                                },
                              );
                            }
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("user")
                              .where("uid",
                              isEqualTo: currentUser.currentUser!.uid)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  var data = snapshot.data!.docs[i];
                                  return TextField(
                                    controller: TextEditingController()
                                      ..text = data["fullname"],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.black12,
                                      prefixIcon: Icon(Icons.person_rounded),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        )
                                    ),
                                  );
                                },
                              );
                            } else {
                              return TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Tên',
                                    fillColor: Colors.black12,
                                    prefixIcon: Icon(Icons.person_outline),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    )),
                                controller: fullnameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Vui lòng nhập tên");
                                  }
                                  if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-z0-9A-Z.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Vui lòng nhập tên hợp lệ");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  fullnameController.text = value!;
                                },
                              );
                            }
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Mật khẩu',
                            fillColor: Colors.black12,
                            prefixIcon: Icon(Icons.lock_outlined),
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
                            prefixIcon: Icon(Icons.lock_outline),
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
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          firestore.collection("user").add({
                            "fullname": fullnameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                            "uid": auth.currentUser!.uid
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
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
                        "LƯU",
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
            ],
          ),
        ),
      ),
    );
  }
}
