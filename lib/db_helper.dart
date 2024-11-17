//Single object class
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  /// step 1 Making a Private Constructor
  DbHelper._();

  ///step 2 creating a static global instance to this class
  static final instance = DbHelper._();

  // static DbHelper getInstance() => DbHelper._() // you can also use this type of function

  //Open DB
  Database? mDB;

  ///First initial the Database when database is not open so first open the database
  Future<Database> initDB() async {

    mDB = mDB ?? await openDB();
    print("open db");
    return mDB!;
   /* if(mDB!=null){
      return mDB!;
    }else{
      mDB = await openDB();
      return mDB!;
    }*/
  }

  ///open Database
 Future<Database> openDB() async{
    ///We need to Path for path provider we take path provider by pub.dev and take a path_provider and path and add to terminal
    var dirpath = await getApplicationCacheDirectory();
    //path for db,and name of db
    var dbpath = join(dirpath.path,"noteDB.db");
    return openDatabase(dbpath,version: 1,onCreate: (db,version){
      print("db created");
      ///create tables
      db.execute("create table note ( n_id integer primary key autoincrement, n_title text, n_desc text)");
    });
  }

  //make function for add notes this function is first called initial function than data base is created and not null so database open and
  // database not created so opendb function is call and create a db
  ///insert query
  Future<bool> addNote ({required String titile,required String desc}) async{
    Database db = await initDB();

   int rowseffected = await db.insert("note", {
    "n_title" : titile,
     "n_desc" : desc,
    });

    /*if(rowseffected>0){
      return true;
    }else{
      return false;
    }*/
    return rowseffected>0;
  }

  ///select query
  Future<List<Map<String,dynamic>>>  fethchallnote()async{
    //First call this function for open database
    Database db = await initDB();
    //db.query for select query function
    List<Map<String,dynamic>> allnotes = await db.query("note");

   return allnotes;
  }
 ///update query
  void updatenote() async {
    Database db = await initDB();

  }
///delete query

}