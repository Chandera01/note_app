//Single object class
import 'package:database_exp/note_model.dart';
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

  static final String Table_Note = "note";
  static final String Table_Id = "n_id";
  static final String Table_Column_Title = "n_title";
  static final String Table_Column_Desc = "n_desc";
  static final String Table_Column_Created_At = "n_created_at";
  static final String Table_Column_Complted_At = "n_completd_at";
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
      db.execute("create table $Table_Note ( $Table_Id integer primary key autoincrement, $Table_Column_Title text, $Table_Column_Desc text, $Table_Column_Created_At text, $Table_Column_Complted_At text)");
    });
  }

  //make function for add notes this function is first called initial function than data base is created and not null so database open and
  // database not created so opendb function is call and create a db
  ///insert query
  Future<bool> addNote (Notemodel newnote) async{
    Database db = await initDB();

   int rowseffected = await db.insert(Table_Note, newnote.toMap()

       /*{ Table_Column_Title : titile,
         Table_Column_Desc :desc,
         // Table_Column_Created_At :DateTime.now().microsecondsSinceEpoch.toString(),
         *//*Table_Column_Complted_At :duedateAt,*//*
       }*/
     /*"note", {
    "n_title" : titile,
     "n_desc" : desc,
    }*/
   );

    /*if(rowseffected>0){
      return true;
    }else{
      return false;
    }*/
    return rowseffected>0;
  }

  ///select query by MODEL
  Future<List<Notemodel>>  fethchallnote()async{
    Database db = await initDB();
    List<Notemodel> mNotes =[];

    List<Map<String,dynamic>> allnotes = await db.query(Table_Note);

    for(Map<String,dynamic> eachData in allnotes){
      Notemodel eachNote = Notemodel.frommap(eachData);
      mNotes.add(eachNote);
    }

    return mNotes;
  }

 /* ///select query
  Future<List<Map<String,dynamic>>>  fethchallnote()async{
    //First call this function for open database
    Database db = await initDB();
    //db.query for select query function
    List<Map<String,dynamic>> allnotes = await db.query(Table_Note);
   return allnotes;
  }*/
 ///update query
  Future<bool> updatenote({required String title,required String desc, required int id}) async {
    Database db = await initDB();

    int rowseffected = await db.update(Table_Note, {
      Table_Column_Title : title,
      Table_Column_Desc : desc,
    },where: "$Table_Id = $id");

    return rowseffected>0;
  }
///delete query
  Future<bool> deleatenote({required int id}) async{
    Database db = await initDB();
   int rowseffected =await db.delete(Table_Note,where: "$Table_Id = ?" ,whereArgs: ['$id']);

   return rowseffected>0;
  }

}