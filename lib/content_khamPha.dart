import 'package:flutter/material.dart';
import 'package:flutter2/khamPhaSach/sachMoiNhat.dart';
import 'package:flutter2/services/sach.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'models/post.dart';

class contentKhamPha extends StatefulWidget {
  const contentKhamPha({Key? key}) : super(key: key);

  @override
  State<contentKhamPha> createState() => _contentKhamPhaState();
}

class _contentKhamPhaState extends State<contentKhamPha> {
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Hôm nay đọc gì",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: postData.length,
                      itemBuilder: (context, index){
                        final urlImage = postData[index].anh;
                        return(
                            buildCard(urlImage!, index)
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child:sachMoiNhat())
          ],
        ),
      ),
    );
  }
  Widget buildCard(String urlImage, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 4),
    width: 110,
    height: 120,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network("${postData[index].anh}", height: 150,),
        SizedBox(height: 4,),
        Text("${postData[index].tenSach}", overflow: TextOverflow.ellipsis,),
        Text("${postData[index].tacGia}", overflow: TextOverflow.ellipsis,)
      ],
    ),
  );
}



