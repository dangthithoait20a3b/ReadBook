import 'package:flutter/material.dart';
import 'package:flutter2/home.dart';
import 'package:flutter2/models/post.dart';

class docSach extends StatefulWidget {
  final Post postData;
  const docSach({Key? key, required this.postData}) : super(key: key);

  @override
  State<docSach> createState() => _docSachState();
}

class _docSachState extends State<docSach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        }, icon: Icon(Icons.chevron_left, color: Colors.black,)),
        title: Text("${widget.postData.tenSach}", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network("${widget.postData.anh}", height: 600,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.postData.noiDung}", style: TextStyle(
                    fontSize: 16
                  ),
                  textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
