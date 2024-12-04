import 'package:database_exp/db_helper.dart';

class Notemodel {
  ///
  int? id;
  String titile;
  String desc;

  Notemodel({this.id,
    required this.titile,
    required this.desc});

  factory Notemodel.frommap(Map<String,dynamic> map){
    return Notemodel(
        id: map[DbHelper.Table_Id],
        titile: map[DbHelper.Table_Column_Title],
        desc: map[DbHelper.Table_Column_Desc],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.Table_Column_Title : titile,
      DbHelper.Table_Column_Desc :desc,
    };
  }
}
