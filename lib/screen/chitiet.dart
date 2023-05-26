import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/docSach/docSach.dart';
import 'package:flutter2/home.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/favorite/FavoriteManager.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chiTietBook extends StatefulWidget {
  final Post postData;
  const chiTietBook({Key? key, required this.postData}) : super(key: key);

  static Widget create({required Post postData}) =>
      chiTietBook(postData: postData);

  @override
  State<chiTietBook> createState() => _chiTietBookState();
}

class _chiTietBookState extends State<chiTietBook> {
  final currentUser = FirebaseAuth.instance;
  User? user;

  bool _iconBool = true;
  FavoriteManager _favoriteManager = FavoriteManager();
  bool _isFavorite = false;
  final DatabaseReference _favoriteRef = FirebaseDatabase.instance.reference().child('users').child('userId').child('favorites');

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await _favoriteManager.removeFromFavorite('userId', widget.postData);
      _favoriteRef.child(widget.postData.id ?? '').remove();
    } else {
      await _favoriteManager.addToFavorite('userId', widget.postData);
      _favoriteRef.child(widget.postData.id ?? '').set({
        'id': widget.postData.id,
        'tenSach': widget.postData.tenSach,
        'anh': widget.postData.anh,
        'tacGia': widget.postData.tacGia,
        'ngonNgu': widget.postData.ngonNgu,
        'theLoai': widget.postData.theLoai,
        'moTa': widget.postData.moTa
      });
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });

    _prefs.setBool(widget.postData.id!, _isFavorite);
  }

  late SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      setState(() {
        _isFavorite = _prefs.getBool(widget.postData.id!) ?? false;
        user =currentUser.currentUser;
      });
    });
  }

  Future<void> _saveBookToHistory(Post postData) async {
    final history = _prefs.getStringList('history') ?? [];
    if (history.contains(postData.id)) return;
    history.add(postData.id ?? ''); // Add '' as fallback value if postData.id is null
    await _prefs.setStringList('history', history);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.chevron_left, color: Colors.black,)),
        title: Text("${widget.postData.tenSach}", style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),),
        actions: [

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
                                           _toggleFavorite();
                                         },
                                         icon: Icon(
                                           _isFavorite ? Icons.favorite : Icons.favorite_border,
                                           color: _isFavorite ? Colors.red : Colors.grey,
                                         ),
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
                                       child:  IconButton(
                                         onPressed: () {
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
                       onPressed: () {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.white,
                          content: Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mua Sách Giấy", style: TextStyle(
                                  color: Colors.grey
                                ),),
                                Text("Shopee", style: TextStyle(
                                  color: Colors.black
                                ),),
                                Text("Tiki",style: TextStyle(
                                  color: Colors.black
                                ),),
                                InkWell(
                                  child: Text("Cancel",style: TextStyle(
                                      color: Colors.red,
                                  ),),
                                  onTap: ()=>Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                       },
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
                          Text("${widget.postData.theLoai} > ${widget.postData.chiTietTheLoai}")
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
                    onPressed: ()async {
                      await _saveBookToHistory(widget.postData);
                      user != null ? Navigator.push(context,MaterialPageRoute(builder: (context) => docSach(postData: widget.postData)))
                          : Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Column(
                    children: [
                      Text("Đánh giá sách" , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16
                      ),),
                    ],
                     ),
                     Column(
                         children: [
                           TextButton(onPressed: (){}, child: Text("Xem tất cả"))
                         ],
                     )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
