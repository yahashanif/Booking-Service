class BookingRequest {
  String? idPelanggan;
  String? tglBooking;
  List<DetailBookings2>? detailBookings;

  BookingRequest({this.idPelanggan, this.tglBooking, this.detailBookings});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    idPelanggan = json['id_pelanggan'];
    tglBooking = json['tgl_booking'];
    if (json['detail_bookings'] != null) {
      detailBookings = <DetailBookings2>[];
      json['detail_bookings'].forEach((v) {
        detailBookings!.add(new DetailBookings2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pelanggan'] = this.idPelanggan;
    data['tgl_booking'] = this.tglBooking;
    if (this.detailBookings != null) {
      data['detail_bookings'] =
          this.detailBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  Map<String, dynamic> toJson2(int id) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_booking'] = id;
    data['id_pelanggan'] = this.idPelanggan;
    data['tgl_booking'] = this.tglBooking;
    if (this.detailBookings != null) {
      data['detail_bookings'] =
          this.detailBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailBookings2 {
  RProduct? product;
  int? qty;

  DetailBookings2({this.product, this.qty});

  DetailBookings2.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new RProduct.fromJson(json['product']) : null;
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['qty'] = this.qty;
    return data;
  }
}

class RProduct {
  int? id;

  RProduct({this.id});

  RProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}