import 'package:flutter/material.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/search/search.dart';
import 'package:flutter2/services/sach.dart';

import '../screen/chitiet.dart';

class templateTheLoai extends StatefulWidget {
  final Post postData;
  final String selectedCategory;
  const templateTheLoai({Key? key, required this.postData,required this.selectedCategory}) : super(key: key);

  @override
  State<templateTheLoai> createState() => _templateTheLoaiState();
}

class _templateTheLoaiState extends State<templateTheLoai> {
  List<Post> postData = [];
  @override
  void initState() {
    super.initState();
    sachAPI.fetchPost().then((dataFromServer) {
      setState(() {
        postData = widget.selectedCategory != null
            ? dataFromServer.where((post) => post.theLoai == widget.selectedCategory).toList()
            : dataFromServer;
      });
    });
  }
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("${widget.postData.theLoai}", style: TextStyle(
              fontSize: 16,
              color: Colors.black
          ),),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.chevron_left, color: Colors.grey,)),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => search()));
            }, icon: Icon(Icons.search, color: Colors.grey,))
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                      maxCrossAxisExtent: 140,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 10,
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
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
