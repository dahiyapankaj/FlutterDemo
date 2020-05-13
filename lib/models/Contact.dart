import 'package:flutterapp/db/DbHelper.dart';

class Contact {
  int _id;
  String _mobile;
  String _landLine;
  String _name;
  String _image;
  bool _fav;

  Contact(this._name, this._mobile, this._landLine, this._fav, [this._image]);

  Contact.withId(this._id, this._name, this._mobile, this._landLine, this._fav,
      [this._image]);

  /// Setters
  set id(int id) {
    this._id = id;
  }

  set mobile(String mobile) {
    this._mobile = mobile;
  }

  set landLine(String landLine) {
    this._landLine = landLine;
  }

  set name(String name) {
    this._name = name;
  }

  set image(String image) {
    this._image = image;
  }

  set fav(bool fav) {
    this._fav = fav;
  }

  /// getters
  int get id => _id;

  String get mobile => _mobile;

  String get landLine => _landLine;

  String get name => _name;

  String get image => _image;

  bool get fav => _fav;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map[DbHelper.COLUMN_ID] = _id;
    }
    map[DbHelper.COLUMN_NAME] = _name;
    map[DbHelper.COLUMN_MOBILE] = _mobile;
    map[DbHelper.COLUMN_LANDLINE] = _landLine;
    map[DbHelper.COLUMN_IMAGE] = _image;
    map[DbHelper.COLUMN_FAV] = _fav ? 1 : 0;
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    this._id = map[DbHelper.COLUMN_ID];
    this._name = map[DbHelper.COLUMN_NAME];
    this._mobile = map[DbHelper.COLUMN_MOBILE];
    this._landLine = map[DbHelper.COLUMN_LANDLINE];
    this._image = map[DbHelper.COLUMN_IMAGE];
    this._fav = map[DbHelper.COLUMN_FAV] == 1;
  }
}
