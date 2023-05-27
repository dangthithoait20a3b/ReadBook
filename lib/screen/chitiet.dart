import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Login/Login.dart';
import 'package:flutter2/docSach/docSach.dart';
import 'package:flutter2/home.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/favorite/FavoriteManager.dart';
import 'package:flutter2/screen/review.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class chiTietBook extends StatefulWidget {
  final Post postData;
  const chiTietBook({Key? key, required this.postData}) : super(key: key);

  static Widget create({required Post postData}) =>
      chiTietBook(postData: postData);

  @override
  State<chiTietBook> createState() => _chiTietBookState();
}

class _chiTietBookState extends State<chiTietBook> {
  TextEditingController _commentController = TextEditingController();
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
  //rating
  int _ratingValue = 0;
  bool _isRatingEnabled = true;
  final _ratingRef = FirebaseDatabase.instance.reference().child('ratings');
  List<Ratings> _ratingList = []; // Khai báo và khởi tạo danh sách đánh giá sách




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
  Future<void> _saveRating() async {
    _prefs.setInt(widget.postData.id!, _ratingValue);
    if (FirebaseAuth.instance.currentUser == null) {
      // Nếu người dùng chưa đăng nhập, hiển thị màn hình đăng nhập.
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      // Lưu đánh giá của người dùng lên Firebase
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String bookId = widget.postData.id!;
      _ratingRef.child(userId).child(bookId).set({
        'rating': _ratingValue,
        'comment': _commentController.text
      });

      // Không cho phép người dùng đánh giá lại
      setState(() {
        _isRatingEnabled = false;
      });
    }
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
                        child: Image.network("${widget.postData.anh}", height: 250,width: 130),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
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
                               // Row(
                               //   children: [
                               //     RatingBar.builder(
                               //       initialRating: _ratingValue.toDouble(),
                               //       minRating: 1,
                               //       maxRating: 5,
                               //       itemCount: 5,
                               //       itemSize: 25,
                               //       allowHalfRating: false,
                               //       ignoreGestures: !_isRatingEnabled,
                               //       itemBuilder: (context, _) => Icon(
                               //         _ratingValue >= _ ? Icons.star : Icons.star_border,
                               //         color: Colors.amber,
                               //       ),
                               //       onRatingUpdate: (value) {
                               //         setState(() {
                               //           _ratingValue = value.toInt();
                               //         });
                               //       },
                               //     ),
                               //
                               //   ],
                               // )

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
                                         margin: EdgeInsets.only(left:5,right: 5),
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

                                 ],
                               )
                             ],
                           ),
                           Column(
                             children: [
                               Container(
                                 width: 40,
                                 height: 40,
                                 margin: EdgeInsets.only(right: 10, left: 5),
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
                               ),
                           ]
                           ),
                           Column(
                             children: [
                               SizedBox(
                                 height: 35,
                                 width: 35,
                                 child: Stack(
                                   children: [
                                     ElevatedButton(
                                       onPressed: () {
                                         if (currentUser.currentUser == null) {
                                           // Nếu người dùng chưa đăng nhập, hiển thị màn hình đăng nhập.
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                         } else {
                                           showDialog(
                                             context: context,
                                             builder: (BuildContext context) => AlertDialog(
                                               title: Text('Nhập đánh giá'),
                                               content: Column(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Đánh giá của bạn'),
                                                   RatingBar.builder(
                                                     initialRating: _ratingValue.toDouble(),
                                                     minRating: 1,
                                                     maxRating: 5,
                                                     itemCount: 5,
                                                     itemSize: 30,
                                                     allowHalfRating: false,
                                                     ignoreGestures: !_isRatingEnabled,
                                                     itemBuilder: (context, _) => Icon(
                                                       _ratingValue >= _ ? Icons.star : Icons.star_border,
                                                       color: Colors.amber,
                                                     ),
                                                     onRatingUpdate: (value) {
                                                       setState(() {
                                                         _ratingValue = value.toInt();
                                                       });
                                                     },
                                                   ),
                                                   SizedBox(height: 10,),
                                                   TextField(
                                                     onChanged: (value) {
                                                       //Lưu đánh giá của người dùng
                                                       _commentController.text = value;
                                                     },
                                                     maxLines: 5,
                                                     controller: _commentController,
                                                     decoration: InputDecoration(
                                                       hintText: 'Nhập đánh giá của bạn',
                                                       border: OutlineInputBorder(),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               actions: [
                                                 TextButton(
                                                   onPressed: () {
                                                     //Lưu đánh giá của người dùng lên Firebase
                                                     _saveRating();
                                                     Navigator.of(context).pop();
                                                   },
                                                   child: Text('Lưu'),
                                                 ),
                                                 TextButton(
                                                   onPressed: () {
                                                     Navigator.of(context).pop();
                                                   },
                                                   child: Text('Hủy'),
                                                 ),
                                               ],
                                             ),
                                           );
                                         }
                                       },
                                       child: Center(child: Icon(Icons.star , color: Colors.amber,)),
                                       style: ElevatedButton.styleFrom(
                                         // adjust padding as needed
                                         padding: EdgeInsets.only(top: 0),
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(60), // adjust border radius as needed
                                         ),
                                         primary: Colors.grey[300], // set background color to white
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           )
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
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Đánh giá sách",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () { /* handle see all ratings */ },
                              child: Text("Xem tất cả"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _ratingList.length,
                      itemBuilder: (context, index) {
                        final rating = _ratingList[index];
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: rating.rating.toDouble(),
                                      minRating: 1,
                                      itemCount: 5,
                                      itemSize: 20,
                                      allowHalfRating: false,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                      onRatingUpdate: (_) {},
                                    ),
                                    SizedBox(width: 10),
                                    // Text(
                                    //   currentUser.uid == rating.userId ? "Bạn" : "Người dùng ${rating.userId}",
                                    //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(rating.comment ?? "",
                                  style: TextStyle(fontSize: 16,color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
