import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final userRef = FirebaseDatabase.instance.reference().child('users').child(currentUser.currentUser!.uid);
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
  bool _isUpdatingPassword = false;
  String? _errorMessage;

  Future<void> _onSubmit() async {
    if (_newPasswordController.text != _confirmNewPasswordController.text) {
      setState(() {
        _isUpdatingPassword = false;
        _errorMessage = 'Mật khẩu mới và mật khẩu nhập lại không khớp!';
      });
      return;
    }
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
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: userRef.onValue,
                      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          var data = snapshot.data!.snapshot.value;

                          return Padding(
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
                                        hintText: 'Email',
                                        fillColor: Colors.grey.shade100,
                                        prefixIcon: Icon(Icons.lock_outline),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        )),
                                    style: TextStyle(color: Colors.black),
                                    controller: TextEditingController()
                                      ..text = (data as Map)['email'] ?? "",
                                    onSaved: (value) {
                                      emailController.text = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintText: 'FullName',
                                        fillColor: Colors.grey.shade100,
                                        prefixIcon: Icon(Icons.lock_outline),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        )),
                                    style: TextStyle(color: Colors.black),
                                    controller: TextEditingController()
                                      ..text = (data as Map)['fullname'] ?? "",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Vui lòng nhập họ và tên");
                                      }
                                    },
                                    onSaved: (value) {
                                      fullnameController.text = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintText: 'Mật khẩu mới',
                                        fillColor: Colors.grey.shade100,
                                        prefixIcon: Icon(Icons.lock_outline),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        )),
                                    style: TextStyle(color: Colors.black),
                                    controller: TextEditingController(),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Vui lòng nhập mật khẩu mới");
                                      }
                                    },
                                    onSaved: (value) {
                                      _newPasswordController.text = value!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintText: 'Nhập lại mật khẩu',
                                        fillColor: Colors.grey.shade100,
                                        prefixIcon: Icon(Icons.lock_outline),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        )),
                                    style: TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Vui lòng nhập lại mật khẩu");
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                userRef.update({
                                  'email':emailController.text,
                                  'fullname':fullnameController.text,
                                  'password':_newPasswordController.text
                                }).then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content:Text("Thông tin của bạn đã được cập nhật")
                                  ));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => changeInformation()));
                                }).catchError((onError){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content:Text("Vui lòng thử lại ")
                                  ));
                                }
                                );
                              }

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
            ],
          ),
        ),
      ),
    );
  }
}
