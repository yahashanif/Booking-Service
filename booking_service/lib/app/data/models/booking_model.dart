import 'package:booking_service/app/data/models/pelanggan_model.dart';

class Booking {
  int? id;
  Pelanggan? pelanggan;
  String? tglBooking;
  List<DetailBookings>? detailBookings;
  double? total;

  Booking(
      {this.id,
      this.pelanggan,
      this.tglBooking,
      this.detailBookings,
      this.total});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pelanggan = json['pelanggan'] != null
        ? new Pelanggan.fromJson(json['pelanggan'])
        : null;
    tglBooking = json['tgl_booking'];
    if (json['DetailBookings'] != null) {
      detailBookings = <DetailBookings>[];
      json['DetailBookings'].forEach((v) {
        detailBookings!.add(new DetailBookings.fromJson(v));
      });
    }
    total = double.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.pelanggan != null) {
      data['pelanggan'] = this.pelanggan!.toJson();
    }
    data['tgl_booking'] = this.tglBooking;
    if (this.detailBookings != null) {
      data['DetailBookings'] =
          this.detailBookings!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

// class Pelanggan {
//   int? id;
//   String? name;
//   String? noHp;
//   String? alamat;

//   Pelanggan({this.id, this.name, this.noHp, this.alamat});

//   Pelanggan.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     noHp = json['no_hp'];
//     alamat = json['alamat'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['no_hp'] = this.noHp;
//     data['alamat'] = this.alamat;
//     return data;
//   }
// }

class DetailBookings {
  int? idBooking;
  Product? product;
  int? qty;
  int? subtotal;

  DetailBookings({this.idBooking, this.product, this.qty, this.subtotal});

  DetailBookings.fromJson(Map<String, dynamic> json) {
    idBooking = json['id_booking'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    qty = json['qty'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_booking'] = this.idBooking;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['qty'] = this.qty;
    data['subtotal'] = this.subtotal;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  Categories? categories;
  int? stock;
  int? harga;
  String? imageUrl;

  Product(
      {this.id,
      this.name,
      this.categories,
      this.stock,
      this.harga,
      this.imageUrl});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
    stock = json['stock'];
    harga = json['harga'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    data['stock'] = this.stock;
    data['harga'] = this.harga;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Categories {
  int? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}