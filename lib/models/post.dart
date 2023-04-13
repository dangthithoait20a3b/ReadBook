class Post {
  String? tenSach;
  String? tacGia;
  String? anh;
  String? danhGia;
  String? moTa;
  String? theLoai;
  String? chiTietTheLoai;
  String? ngonNgu;
  String? noiDung;
  String? id;
  bool isFavorite = false;

  Post(
      {this.tenSach,
        this.tacGia,
        this.anh,
        this.danhGia,
        this.moTa,
        this.theLoai,
        this.chiTietTheLoai,
        this.ngonNgu,
        this.noiDung,
        this.id});

  Post.fromJson(Map<String, dynamic> json) {
    tenSach = json['tenSach'];
    tacGia = json['tacGia'];
    anh = json['anh'];
    danhGia = json['danhGia'];
    moTa = json['moTa'];
    theLoai = json['theLoai'];
    chiTietTheLoai = json['chiTietTheLoai'];
    ngonNgu = json['ngonNgu'];
    noiDung = json['noiDung'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenSach'] = this.tenSach;
    data['tacGia'] = this.tacGia;
    data['anh'] = this.anh;
    data['danhGia'] = this.danhGia;
    data['moTa'] = this.moTa;
    data['theLoai'] = this.theLoai;
    data['chiTietTheLoai'] = this.chiTietTheLoai;
    data['ngonNgu'] = this.ngonNgu;
    data['noiDung'] = this.noiDung;
    data['id'] = this.id;
    return data;
  }
}