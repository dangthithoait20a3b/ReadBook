import 'package:flutter/material.dart';
import 'package:flutter2/models/post.dart';
import 'package:flutter2/search/search.dart';
import 'package:flutter2/services/sach.dart';
import 'package:flutter2/tusach_yeuthich.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuSach extends StatefulWidget {
  const TuSach({Key? key}) : super(key: key);

  @override
  State<TuSach> createState() => _TuSachState();
}

class _TuSachState extends State<TuSach> {
  late SharedPreferences _prefs;
  List<Post> _postData = [];
  List<String> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _history = _prefs.getStringList('history') ?? [];
      });
    });
    sachAPI.fetchPost().then((dataFromServer) {
      setState(() {
        _postData = dataFromServer;
        _isLoading = false;
      });
    });
  }

  Future<void> _addToHistory(Post postData) async {
    final history = _prefs.getStringList('history') ?? [];
    if (history.contains(postData.id)) return;

    history.add(postData.id ?? ''); // Add '' as fallback value if postData.id is null
    await _prefs.setStringList('history', history);
    setState(() {
      _history = history;
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
                          width: 315,
                          margin: EdgeInsets.only(top: 30, left: 10),
                          child: InkWell(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.search))
                                  ],
                                ),
                                Column(
                                  children: [Text("Tìm kiếm sách của tôi")],
                                )
                              ],
                            ),
                            onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => search())),
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
                      padding: EdgeInsets.only(top: 30, right: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => tusach_yeuthich()));
                        },
                        icon: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(top: 30),
                //       child: IconButton(
                //         onPressed: () {},
                //         icon: Icon(Icons.library_books_outlined),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "TẤT CẢ",
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
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  "Đọc gần đây",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                _isLoading ? Container(
                    padding: EdgeInsets.only(top: 200),
                    child: Center(child: CircularProgressIndicator())) : Expanded(
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 140,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5
                    ),
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          final post = _postData.firstWhere((post) => post.id == _history[index], orElse: () => Post()); // Using a default value
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
                                        '${post.anh}',
                                        fit: BoxFit.fill,
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${post.tenSach}",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${post.tacGia}",
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
                    )
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

