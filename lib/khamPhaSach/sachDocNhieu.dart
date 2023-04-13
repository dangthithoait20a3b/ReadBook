import 'package:flutter/material.dart';

class sachDocNhieu extends StatefulWidget {
  const sachDocNhieu({Key? key}) : super(key: key);

  @override
  State<sachDocNhieu> createState() => _sachDocNhieuState();
}

class _sachDocNhieuState extends State<sachDocNhieu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text("Sách đọc nhiều",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black
                    ),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      child: Text("Xem tất cả",style: TextStyle(
                        color: Colors.blue
                      ),),
                      onTap: (){},
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
