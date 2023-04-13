import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/home.dart';
import 'package:flutter2/khampha.dart';

class logged extends StatefulWidget {
  const logged({Key? key}) : super(key: key);

  @override
  State<logged> createState() => _loggedState();
}

class _loggedState extends State<logged> {
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 30),
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
                Expanded(
                  child: InkWell(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("user")
                          .where("uid", isEqualTo: currentUser.currentUser!.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];
                              return InkWell(
                                child: Text(
                                  data['fullname'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    onTap: () {},
                  ),
                )
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
                              onPressed: () {}, icon: Icon(Icons.chevron_right))
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
                              onPressed: () {}, icon: Icon(Icons.chevron_right))
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
                            "Phản hồi về ứng dụng",
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
                            children: [Text("Liên hệ, phản hồi")],
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
    );
  }
}
