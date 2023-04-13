import 'package:flutter/material.dart';
import 'package:flutter2/docSach/docSach.dart';
import 'package:flutter2/home.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

class chiTietBook extends StatefulWidget {
  final Post postData;
  const chiTietBook({Key? key, required this.postData}) : super(key: key);

  static Widget create({required Post postData}) =>
      chiTietBook(postData: postData);

  @override
  State<chiTietBook> createState() => _chiTietBookState();
}

class _chiTietBookState extends State<chiTietBook> {
  bool _iconBool = true;
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
        actions: [
          Row(
            children: [
              Column(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.share, color: Colors.black,))
                ],
              ),
              Column(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.verified , color: Colors.yellow, size: 30,))
                ],
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.network("${widget.postData.anh}", height: 200,),
                      )
                    ],
                  ),
                  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       width: 220,
                       child: Text("${widget.postData.tenSach}",
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 16,
                           overflow: TextOverflow.ellipsis
                         ),),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Text("${widget.postData.tacGia}",
                       style: TextStyle(
                         color: Colors.grey,
                         fontSize: 16
                     ),),
                     SizedBox(
                       height: 10,
                     ),
                     Row(
                       children: [
                         Column(
                           children: [
                             Row(
                               children: [
                                 Column(
                                   children: [
                                     Icon(Icons.star_border_outlined,
                                       color: Colors.yellow[700],
                                     ),
                                   ],
                                 ),
                                 Column(
                                   children: [
                                     Icon(Icons.star_border_outlined,
                                       color: Colors.yellow[700],
                                     ),
                                   ],
                                 ),
                                 Column(
                                   children: [
                                     Icon(Icons.star_border_outlined,
                                       color: Colors.yellow[700],
                                     ),
                                   ],
                                 ),
                                 Column(
                                   children: [
                                     Icon(Icons.star_border_outlined,
                                       color: Colors.yellow[700],
                                     ),
                                   ],
                                 ),
                                 Column(
                                   children: [
                                     Icon(Icons.star_border_outlined,
                                       color: Colors.yellow[700],
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ],
                         ),
                         Column(
                           children: [
                             Row(
                               children: [
                                 Column(
                                   children: [
                                     Container(
                                       width: 40,
                                       height: 40,
                                       margin: EdgeInsets.only(top:20,left:5,right: 5),
                                       child: IconButton(
                                         onPressed: (){
                                           setState(() {
                                             _iconBool = !_iconBool;
                                           });
                                         },
                                         icon: _iconBool ? Icon(Icons.favorite_border, color: Colors.grey,) : Icon(Icons.favorite, color: Colors.red,),
                                       ),
                                       decoration: BoxDecoration(
                                           color: Colors.grey[300],
                                           borderRadius: BorderRadius.circular(50)
                                       ),
                                     )
                                   ],
                                 ),
                                 Column(
                                   children: [
                                     Container(
                                       width: 40,
                                       height: 40,
                                       margin: EdgeInsets.only(top: 20),
                                       child: IconButton(
                                         onPressed: (){
                                           setState(() {
                                             _iconBool = !_iconBool;
                                           });
                                         },
                                         icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey,),
                                       ),
                                       decoration: BoxDecoration(
                                           color: Colors.grey[300],
                                           borderRadius: BorderRadius.circular(50)
                                       ),
                                     )
                                   ],
                                 )
                               ],
                             )
                           ],
                         ),
                       ],
                     ),
                     SizedBox(
                       height: 35,
                     ),
                     MaterialButton(
                       onPressed: () {},
                       color: Colors.green[300],
                       minWidth: 200,
                       height: 35,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(5)),
                       child: Text(
                         "Mua Sách",
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w700,
                           color: Color.fromRGBO(255, 255, 255, 1),
                         ),
                       ),
                     ),

                   ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                child: ExpandableText(
                "${widget.postData.moTa},",
                  readLessText: 'Rút gọn',
                  readMoreText: 'Xem thêm',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                  ),
                )
              ),
              SizedBox(height: 10,),
              Container(
                child: Text("Thông tin chi tiết", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              ),
              Container(
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Thể loại")
                        ],
                      ),
                      Column(
                        children: [
                          Text("${widget.postData.theLoai}")
                        ],
                      )
                    ],
                  ),
                )
              ),
              Container(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Tác giả")
                          ],
                        ),
                        Column(
                          children: [
                            Text("${widget.postData.tacGia}")
                          ],
                        )
                      ],
                    ),
                  )
              ),
              Container(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Ngôn ngữ")
                          ],
                        ),
                        Column(
                          children: [
                            Text("${widget.postData.ngonNgu}")
                          ],
                        )
                      ],
                    ),
                  )
              ),
              Positioned(
                child: Center(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => docSach(postData: widget.postData)));
                    },
                    color: Colors.green[300],
                    minWidth: 200,
                    height: 35,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Đọc Sách",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
