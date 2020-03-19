class UserModel {
  String pseudo, password, id;
  UserModel({this.pseudo, this.password, this.id });
  UserModel.fromJson(Map<String, dynamic> json)
      : pseudo = json['pseudo'],
        password = json['password'],
        id = json['id'];

  @override
  Map<String, dynamic> toMap() {
    return {
      "pseudo": pseudo,
      "password": password,
      "id": id == null ? "" : id
    };
  }
}