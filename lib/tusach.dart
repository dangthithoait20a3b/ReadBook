import 'package:flutter/material.dart';

class TuSach extends StatefulWidget {
  const TuSach({Key? key}) : super(key: key);

  @override
  State<TuSach> createState() => _TuSachState();
}

class _TuSachState extends State<TuSach> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Tủ sách"),
    );
  }
}
