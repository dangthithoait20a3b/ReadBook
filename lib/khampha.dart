import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';

class KhamPha extends StatefulWidget {
  const KhamPha({Key? key}) : super(key: key);

  @override
  State<KhamPha> createState() => _KhamPhaState();
}

class _KhamPhaState extends State<KhamPha> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: null,
          centerTitle: true,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(

          child: Column(
            children: [
              Container(
                  height: 90,
                  color: Colors.grey,
                  padding: EdgeInsets.only(left: 5,top: 15,bottom: 5),
                  child: headerWidget(context)),
              ListTile(
                title: Text('THỂ LOẠI SÁCH', style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold
                ),),
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
Widget headerWidget(context){
  const url = 'https://www.pngall.com/wp-content/uploads/5/Profile.png';
  return Row(
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(url),
      ),
      const SizedBox(width: 20,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.only(top: 30),
              child: Text('ĐĂNG NHẬP',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
              ),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      )
    ],
  );
}
