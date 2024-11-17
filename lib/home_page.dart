import 'package:database_exp/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  DbHelper dbHelper = DbHelper.instance;
  List<Map<String,dynamic>> mData = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes()async{
    mData = await dbHelper.fethchallnote();
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: mData.isNotEmpty ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (_,index){
        return ListTile(
          leading: Text(mData[index]["n_id"].toString()),
          title: Text(mData[index]["n_title"]),
          subtitle:  Text(mData[index]["n_desc"]),
          trailing: SizedBox(
            width: 100,
            child: Row(
                children: [
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.update)),
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.delete,color: Colors.red,)),
                ],
            ),
          ),
        );
      }) : Center(child: Text('No notes Yet!!'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool check = await dbHelper.addNote(
              titile: "My Note",
              desc: "Today was a fantastic day as such everyday");

          if (check) {
            print("Note added Successfully");
            getNotes();
          } else {
            print("Failed to add note");
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
