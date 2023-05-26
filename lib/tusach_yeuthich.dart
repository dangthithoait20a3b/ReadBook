import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/docSach/docSach.dart';
import 'package:flutter2/favorite/FavoriteManager.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/screen/chitiet.dart';

class tusach_yeuthich extends StatefulWidget {
  const tusach_yeuthich({Key? key}) : super(key: key);

  @override
  State<tusach_yeuthich> createState() => _tusach_yeuthichState();
}

class _tusach_yeuthichState extends State<tusach_yeuthich> {
  FavoriteManager _favoriteManager = FavoriteManager();



  @override
  Widget build(BuildContext context) {
    Stream<List<Post>> _favoriteListStream = _favoriteManager.getFavorite("userId");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Tủ sách yêu thích"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: StreamBuilder<List<Post>>(
            stream: _favoriteListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Post> favorites = snapshot.data!;
                // display the favorites in your UI
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // number of columns
                    childAspectRatio: 0.65, // width to height ratio of each item
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    Post favorite = favorites[index];
                    return InkWell(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4), // khoảng cách Images
                                color: Colors.grey,
                                width: double.infinity,
                                child: Image.network(
                                  '${favorite.anh}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "${favorite.tenSach}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${favorite.tacGia}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => chiTietBook(postData: favorite)));
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error loading favorites');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
