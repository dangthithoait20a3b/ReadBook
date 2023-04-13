import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/Login/logged.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
final currentUser = FirebaseAuth.instance;
User? user;


class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = currentUser.currentUser; // kiểm tra nếu người dùng đang đăng nhập hoặc null
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (user != null)? Expanded(child: logged()): Expanded(child: Login())
      ],
    );
  }
}
