import 'package:flutter/material.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/screen/chitiet.dart';
import 'package:flutter2/services/sach.dart';
import 'package:http/http.dart';



class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  List<Post> postData = [];
  List<Post> _postsDisplay = <Post>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sachAPI.fetchPost().then((value) {
      setState(() {
        postData.addAll(value);
        _postsDisplay = postData;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _postsDisplay.length + 1,
        itemBuilder: (BuildContext context, int index){
          return index == 0 ? _searchBar() : _listItem(index - 1);
        },
      ),
    );
  }
  _searchBar(){
    return Padding(padding: EdgeInsets.all(8),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Tìm kiếm sách"
      ),
      onChanged: (text){
        text = text.toLowerCase();
        setState(() {
          _postsDisplay = postData.where((post){
            var posttile = post.tenSach!.toLowerCase();
            return posttile.contains(text);
          }).toList();
        });
      },
    ),);
  }
  _listItem(index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_postsDisplay[index].tenSach}",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "${_postsDisplay[index].theLoai}",
                style: TextStyle(
                    color: Colors.grey
                ),
              )
            ],
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => chiTietBook( postData: _postsDisplay[index],)));
          },
        ),
      ),
    );
  }
}

