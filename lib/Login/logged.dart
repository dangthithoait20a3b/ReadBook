import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/home.dart';
import 'package:flutter2/khampha.dart';
import 'package:flutter2/member/members.dart';
import 'package:flutter2/profile/changeimformation.dart';

class logged extends StatefulWidget {
  const logged({Key? key}) : super(key: key);

  @override
  State<logged> createState() => _loggedState();
}

class _loggedState extends State<logged> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phanhoiController = TextEditingController();
  Future<Map<String, String>> _getUserData(User user) async {
    if (user.providerData[0].providerId == 'google.com') {
      return {'name': user.displayName!, 'source': 'google'};
    } else {
      final databaseRef = FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(user.uid)
          .child('fullname');
      DatabaseEvent event = await databaseRef.once();
      DataSnapshot snapshot = event.snapshot;
      final fullname = snapshot.value.toString();
      return {'name': fullname, 'source': 'realtime_database'};
    }
  }
  final userRef = FirebaseDatabase.instance.reference().child('users').child(currentUser.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 20, left: 30),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                            width: 80,
                            height: 80,
                          ),
                          borderRadius: BorderRadius.circular(80),
                        )
                      ],
                    ),
                  ),
        FutureBuilder(
          future: _getUserData(user!),
          builder:
              (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      ' ${userData['name']}',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Error retrieving user data'));
            }
          },
        ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Gói tài khoản",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [Text("Bạn chưa đăng ký thành viên VIP")],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("Đăng ký VIP")],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => members()));
                                }, icon: Icon(Icons.chevron_right))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("Khôi phục gói đăng ký")],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => members()));
                                }, icon: Icon(Icons.chevron_right))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Thông tin tài khoản",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [Text("Thay đổi thông tin")],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => changeInformation()));
                                    },
                                    icon: Icon(Icons.chevron_right))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Phản hồi về ứng dụng",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [Text("Liên hệ, phản hồi"),

                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                      onPressed: () {
                                        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                          shape: RoundedRectangleBorder(  // thiết lập hình dạng khung vuông
                                            borderRadius: BorderRadius.circular(16),  // đặt bán kính đường viền thành 0 để tạo khung vuông
                                            side: BorderSide(color: Colors.grey, width: 2),  // thiết lập màu và độ rộng của đường viền

                                          ),
                                          content: StreamBuilder(
                                            stream: userRef.onValue,
                                            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data!.snapshot.value != null) {
                                                var data = snapshot.data!.snapshot.value;

                                                return Container(
                                                  height: 220,
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
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                                borderSide: BorderSide.none,
                                                              )),
                                                          style: TextStyle(color: Colors.black),
                                                          controller: TextEditingController()
                                                            ..text = (data as Map)['email'] ?? "",
                                                          onSaved: (value) {
                                                            emailController.text = value!;
                                                          },
                                                          enabled: false,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextFormField(
                                                          decoration: InputDecoration(
                                                              filled: true,
                                                              hintText: 'FullName',
                                                              fillColor: Colors.grey.shade100,
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
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
                                                          enabled: false,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                                filled: true,
                                                                hintText: 'Phản hồi',
                                                                fillColor: Colors.grey.shade100,
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  borderSide: BorderSide.none,
                                                                )),
                                                            style: TextStyle(color: Colors.black),
                                                            controller: TextEditingController(),
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return ("Vui lòng nhập phản hồi");
                                                              }
                                                            },
                                                            onSaved: (value) {
                                                              phanhoiController.text = value!;
                                                            },
                                                          ),
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
                                          actions: [
                                            ElevatedButton(onPressed: (){
                                              if(_formKey.currentState!.validate()){
                                                _formKey.currentState!.save();
                                                userRef.update({
                                                  'email':emailController.text,
                                                  'fullname':fullnameController.text,
                                                  'phanhoi':phanhoiController.text
                                                }).then((value){
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content:Text("Phản hồi của bạn đã được ghi nhận")
                                                  ));
                                                  Navigator.pop(context);
                                                }).catchError((onError){
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content:Text("Vui lòng thử lại ")
                                                  ));
                                                }
                                                );
                                              }
                                            }, child: Text("Gửi phản hồi"))
                                          ],
                                        ));
                                      },
                                      icon: Icon(Icons.chevron_right)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Thông báo"),
                                  content: Text("Xin vui lòng liên hệ với chúng tôi qua email: abc@gmail.com"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Đóng"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [Text("Đánh giá ứng dụng")],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.chevron_right))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Quản lý tài khoản",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [Text("Đăng xuất")],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut().then((value) => {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))
                                      });
                                    },
                                    icon: Icon(Icons.chevron_right))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("Xóa tài khoản")],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.chevron_right))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
