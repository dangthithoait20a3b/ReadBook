import 'package:flutter/material.dart';
import 'package:flutter2/khampha.dart';

class members extends StatefulWidget {
  const members({Key? key}) : super(key: key);

  @override
  State<members> createState() => _membersState();
}

class _membersState extends State<members> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title: Text("Trở Thành Thành Viên Vip", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child:Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child:  Image.network("https://tse2.mm.bing.net/th?id=OIP.4VvOErdNNortQYC6RfRE2wHaGy&pid=Api&P=0", height: 100, width: 100,),
                    ),
                    Text("Vui lòng chọn một gói VIP dưới đây để đăng"),
                    Text("ký thành viên VIP!"),

                  ],
                )
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                          },
                          color: Colors.blueGrey,
                          minWidth: 350,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "9.000 đ - 7 Ngày",
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                          },
                          color: Colors.blueGrey,
                          minWidth: 350,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "30.000 đ - 1 Tháng",
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                          },
                          color: Colors.blueGrey,
                          minWidth: 350,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "80.000 đ - 3 Tháng",
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                          },
                          color: Colors.blueGrey,
                          minWidth: 350,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "300.000 đ - 12 Tháng",
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("* Giá đã bao gồm phí cho kênh thanh toán."),
                    ],
                  ),
                  Container(
                      child: Text("Thanh toán sẽ được tính cho tài khoản Google Play của bạn. Bạn có thể quản lý các gói thanh toán từ ứng dụng Google Play.", textAlign: TextAlign.justify, overflow: TextOverflow.clip,)
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                    },
                    color: Colors.blueGrey,
                    minWidth: 330,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Đăng ký",
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
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Quyền lợi thành viên Vip", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontSize: 18
                      ))
                    ],
                  ),
                  Container(
                    child: Text("- Không quảng cáo, mang lại trải nghiẹm sử dụng ứng dụng nhanh và mượt mà nhất.", textAlign: TextAlign.justify, ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text("- Hỗ trợ đọc sách trong tủ sách của bạn khi không có kết nối mạng", textAlign: TextAlign.justify,),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text("- Đồng bộ dữ liệu đọc sách giữa các thiết bị của bạn.", textAlign: TextAlign.justify,),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text("- Đọc tiếp cuốn sách đang đọc một các nhanh chóng.", textAlign: TextAlign.justify,),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Text(" Các chức năng nâng cao sẽ được phát triển chỉ dành riêng cho thành viên VIP.", textAlign: TextAlign.justify,),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
