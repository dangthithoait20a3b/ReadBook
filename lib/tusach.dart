import 'package:flutter/material.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/services/sach.dart';

class TuSach extends StatefulWidget {
  const TuSach({Key? key}) : super(key: key);

  @override
  State<TuSach> createState() => _TuSachState();
}

class _TuSachState extends State<TuSach> {
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
       child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 children: [
                   Column(
                     children: [
                       Container(
                         width: 285,
                         margin: EdgeInsets.only(top: 30, left: 10),
                         child: Row(
                           children: [
                             Column(
                               children: [
                                 IconButton(onPressed: (){}, icon:Icon(Icons.search) )
                               ],
                             ),
                             Column(
                               children: [
                                 Text("Tìm kiếm sách của tôi")
                               ],
                             )
                           ],
                         ),
                         decoration: BoxDecoration(
                           color: Colors.grey,
                           borderRadius: BorderRadius.circular(30),

                         ),
                       ),
                     ],
                   ),
                 ],
               ),
               Column(
                 children: [
                   Container(
                     padding: EdgeInsets.only(top: 30),
                     child: IconButton(
                       onPressed: (){},
                       icon: Icon(Icons.favorite_border),
                     ),
                   ),
                 ],
               ),
               Column(
                 children: [
                   Container(
                     padding: EdgeInsets.only(top: 30),
                     child: IconButton(
                       onPressed: (){},
                       icon: Icon(Icons.library_books_outlined),
                     ),
                   ),
                 ],
               ),
             ],
           ),
           SizedBox(
             height: 10,
           ),
           Expanded(
             child: Column(
               children: [
                 Container(
                   padding:EdgeInsets.only(left: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         children: [
                           Text("TẤT CẢ",
                             style: TextStyle(
                               color: Colors.blueGrey,
                               fontWeight: FontWeight.bold,
                             ),
                           )
                         ],
                       ),
                       Column(
                         children: [
                         Row(
                           children: [
                             Icon(Icons.arrow_drop_down,
                               color: Colors.blueGrey,
                             ),
                             Text("Đọc gần đây",
                               style: TextStyle(
                                 color: Colors.blueGrey,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Icon(Icons.arrow_drop_down,
                               color: Colors.blueGrey,
                             )
                           ],
                         ),
                         ],
                       ),
                     ],
                   ),
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
                                   child: Image.network(
                                     '${postData[index].anh}',
                                     fit: BoxFit.fill,
                                     height: 150,
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
         ],
       ),
     ),
   );
  }
}
