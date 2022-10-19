class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? profilPathUrl;
  String? level;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.profilPathUrl,
      this.level});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    profilPathUrl = json['profil_path_url'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['profil_path_url'] = profilPathUrl;
    data['level'] = level;
    return data;
  }
}
