import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                            "G??i t??i kho???n",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [Text("B???n ch??a ????ng k?? th??nh vi??n VIP")],
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [Text("????ng k?? VIP")],
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
                        children: [Text("Kh??i ph???c g??i ????ng k??")],
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
                            "Th??ng tin t??i kho???n",
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
                            children: [Text("Thay ?????i th??ng tin")],
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
                            "Ph???n h???i v??? ???ng d???ng",
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
                            children: [Text("Li??n h???, ph???n h???i")],
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
                            children: [Text("????nh gi?? ???ng d???ng")],
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
                            "Qu???n l?? t??i kho???n",
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
                            children: [Text("????ng xu???t")],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut().then((value) => {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => KhamPha()))
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
                        children: [Text("X??a t??i kho???n")],
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
