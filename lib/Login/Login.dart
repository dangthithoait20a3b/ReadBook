import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Register.dart';
import 'package:flutter2/Login/forgotpassword.dart';
import 'package:flutter2/home.dart';
import 'Register.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn();
  Future<void> _signInWithGoogle() async {
    try {
      // Thực hiện đăng nhập Google
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      // Lấy thông tin đăng nhập được trả về từ Google SignIn
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      // Tạo credentials từ Google SignIn Authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Đăng nhập vào Firebase với credentials
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Home())), icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title: Text("Đăng Nhập", style: TextStyle(
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
              Container(
                margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
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
                            prefixIcon: Icon(Icons.lock_outline),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text,
                            password: passwordController.text)
                            .then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
                        "Đăng Nhập",
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30),
                    child: InkWell(
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 130),
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => forgotPassword()));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'images/facebook.png',
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 40, left: 20),
                      child: Image.asset(
                        'images/google.png',
                      ),
                    ),
                    onTap: () => _signInWithGoogle(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Điều khoản sử dụng ứng dụng",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.open_in_new),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
