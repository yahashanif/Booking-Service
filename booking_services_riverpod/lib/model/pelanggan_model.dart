class Pelanggan {
  String? id;
  String? name;
  String? noHp;
  String? alamat;

  Pelanggan({this.id, this.name, this.noHp, this.alamat});

  Pelanggan.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    noHp = json['no_hp'];
    alamat = json['alamat'];
  }

  set value(Pelanggan value) {}

  Map<String, dynamic> toJson() {
    final data = <String, String>{};
    data['name'] = name!;
    data['no_hp'] = noHp!;
    data['alamat'] = alamat!;
    return data;
  }
  Map<String, dynamic> toJson2() {
    final data = <String, dynamic>{};
    data['id'] = int.parse(id!);
    data['name'] = name!;
    data['no_hp'] = noHp!;
    data['alamat'] = alamat!;
    return data;
  }
}
