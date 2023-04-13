import 'package:flutter/material.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/screen/chitiet.dart';
import 'package:flutter2/services/sach.dart';

class sachMoiNhat extends StatefulWidget {
  const sachMoiNhat({Key? key}) : super(key: key);

  @override
  State<sachMoiNhat> createState() => _sachMoiNhatState();
}

class _sachMoiNhatState extends State<sachMoiNhat> {
  List<Post> postData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sachAPI.fetchPost().then((dataFromServer) {
      setState(() {
        postData = dataFromServer;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Sách mới nhất",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text("Xem tất cả",
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("TẤT CẢ",
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_drop_down,
                      color: Colors.blueGrey,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 1/2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 5
              ),
                  itemCount: postData.length,
                  itemBuilder: (BuildContext, index){
                    return  InkWell(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4), // khoảng cách Images
                              color: Colors.grey,
                              width: double.infinity,
                              child: InkWell(
                                child: Image.network(
                                  '${postData[index].anh}',
                                  fit: BoxFit.fill,
                                  height: 150,
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => chiTietBook(postData: postData[index])));
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "${postData[index].tenSach}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${postData[index].tacGia}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
