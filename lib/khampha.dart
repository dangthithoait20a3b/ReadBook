import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/Login/logged.dart';
import 'package:flutter2/content_khamPha.dart';
import 'package:flutter2/member/members.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/notification/notification.dart';
import 'package:flutter2/search/search.dart';
import 'package:flutter2/services/sach.dart';
import 'package:flutter2/template/templateTheLoai.dart';

class KhamPha extends StatefulWidget {
  const KhamPha({Key? key}) : super(key: key);

  @override
  State<KhamPha> createState() => _KhamPhaState();
}

final currentUser = FirebaseAuth.instance;
User? user;

class _KhamPhaState extends State<KhamPha> {
  List<Post> postData = [];
  Map<String?, List<Post>> postGroupedByCategory = {};
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
  @override
  void initState() {
    super.initState();
    user = currentUser.currentUser;
    sachAPI.fetchPost().then((dataFromServer) {
      setState(() {
        postData = dataFromServer;

        // Lọc và gom nhóm các bài viết theo thể loại
        for (final post in postData) {
          if (!postGroupedByCategory.containsKey(post.theLoai)) {
            postGroupedByCategory[post.theLoai] = [];
          }
          postGroupedByCategory[post.theLoai]!.add(post);
        }
      });
    });
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
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => search())),
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
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => notification()));
                  },
                  icon: Icon(Icons.notifications))
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
                      padding: EdgeInsets.only(left: 5, top: 15),
                      child: headerWidget(context)),
                  ListTile(
                    title: Text(
                      'THỂ LOẠI SÁCH',
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 600, // set height explicitly
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postGroupedByCategory.length,
                      itemBuilder: (BuildContext context, int index) {
                        final category =
                            postGroupedByCategory.keys.toList()[index];
                        return ListTile(
                          title: InkWell(
                            child: Text(category!),
                            onTap: () {
                              final List<Post> posts = postGroupedByCategory[category] ?? [];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => templateTheLoai(postData: posts[index], selectedCategory: category)));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

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
            ? Expanded(child:   FutureBuilder(
          future: _getUserData(user!),
          builder:
              (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              return InkWell(
                child: Text(
                  ' ${userData['name']}',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                onTap: () => logged(),
              );
            } else {
              return Center(child: Text('Error retrieving user data'));
            }
          },
        ),)
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  )
                ],
              ))
      ],
    );
  }
}
