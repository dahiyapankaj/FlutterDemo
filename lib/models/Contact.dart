import 'package:flutterapp/db/DbHelper.dart';

class Contact {
  int id;
  String mobile;
  String landLine;
  String name;
  String image;
  bool fav;

  Contact(
      {this.id, this.name, this.mobile, this.landLine, this.fav, this.image});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[DbHelper.COLUMN_ID] = id;
    }
    map[DbHelper.COLUMN_NAME] = name;
    map[DbHelper.COLUMN_MOBILE] = mobile;
    map[DbHelper.COLUMN_LANDLINE] = landLine;
    map[DbHelper.COLUMN_IMAGE] = image;
    map[DbHelper.COLUMN_FAV] = fav ? 1 : 0;

    print("map of object is" + name);
    print("map of object is" + map.toString());
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    this.id = map[DbHelper.COLUMN_ID];
    this.name = map[DbHelper.COLUMN_NAME];
    this.mobile = map[DbHelper.COLUMN_MOBILE];
    this.landLine = map[DbHelper.COLUMN_LANDLINE];
    this.image = map[DbHelper.COLUMN_IMAGE];
    this.fav = map[DbHelper.COLUMN_FAV] == 1;
  }
}
