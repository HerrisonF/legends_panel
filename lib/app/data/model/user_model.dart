class User {

  String id;
  String name;

  User({ this.id = "", this.name = ""});

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
    };
  }

}