import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/Login/logged.dart';
import 'package:flutter2/content_khamPha.dart';
import 'package:flutter2/member/members.dart';
import 'package:flutter2/notification/notification.dart';
import 'package:flutter2/search/search.dart';

class KhamPha extends StatefulWidget {
  const KhamPha({Key? key}) : super(key: key);

  @override
  State<KhamPha> createState() => _KhamPhaState();
}

final currentUser = FirebaseAuth.instance;
User? user;



class _KhamPhaState extends State<KhamPha> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = currentUser.currentUser; // kiểm tra nếu người dùng đang đăng nhập hoặc null
  }
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              child: InkWell(
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.search))
                      ],
                    ),
                    Column(
                      children: [Text("Tìm kiếm sách")],
                    )
                  ],
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>search())),
              ),
            ),
            centerTitle: true,
            foregroundColor: Colors.grey,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => members()));
                  },
                  icon: Icon(
                    Icons.verified,
                    color: Colors.yellow,
                  )),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => notification()));
              }, icon: Icon(Icons.notifications))
            ],
          ),
          body: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    child: contentKhamPha(),
                  ),
                )
              ],
            ),
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 90,
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 5, top: 15, bottom: 5),
                      child: headerWidget(context)),
                  ListTile(
                    title: Text(
                      'THỂ LOẠI SÁCH',
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Văn học trong nước'),
                  ),
                  ListTile(
                    title: Text('Văn học nước ngoài'),
                  ),
                  ListTile(
                    title: Text('Kinh tế'),
                  ),
                  ListTile(
                    title: Text('Tâm lý- Giáo dục'),
                  ),
                  ListTile(
                    title: Text('Triết học'),
                  ),
                  ListTile(
                    title: Text('Tôn giáo'),
                  ),
                  ListTile(
                    title: Text('Chăm sóc gia đình'),
                  ),
                  ListTile(
                    title: Text('Truyện'),
                  ),
                  ListTile(
                    title: Text('Học ngoại ngữ'),
                  ),
                  ListTile(
                    title: Text('Lịch sử- Địa lý'),
                  ),
                  ListTile(
                    title: Text('Khoa học'),
                  ),
                  ListTile(
                    title: Text('Y học- Sức khỏe'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

Widget headerWidget(context) {
  const url = 'https://www.pngall.com/wp-content/uploads/5/Profile.png';
  return Row(
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(url),
      ),
      const SizedBox(
        width: 20,
      ),
      (user != null)
          ? Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("user")
                                  .where("uid",
                                      isEqualTo: currentUser.currentUser!.uid)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                              fontSize: 16,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => logged()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                )
              ],
            ))
    ],
  );
}
