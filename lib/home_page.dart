import 'package:database_exp/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  TextEditingController titilecontroller = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper = DbHelper.instance;
  List<Map<String, dynamic>> mData = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() async {
    mData = await dbHelper.fethchallnote();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: mData.isNotEmpty
          ? ListView.builder(
              itemCount: mData.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Text('${index+1}'),  //Text(mData[index]["n_id"].toString()),
                  title: Text(mData[index]["n_title"]),
                  subtitle: Text(mData[index]["n_desc"]),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {

                              titilecontroller.text = mData[index]["n_title"];
                              descController.text = mData[index]["n_desc"];

                              showModalBottomSheet(
                                  enableDrag: false,
                                  context: context,
                                  builder: (_) {
                                    return Container(
                                      padding: EdgeInsets.all(16),
                                      height: 500,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Update Notes",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          TextField(
                                            controller: titilecontroller,
                                            decoration: InputDecoration(
                                                hintText: "Update Title",
                                                label: Text("Title"),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          TextField(
                                            maxLines: 3,
                                            controller: descController,
                                            decoration: InputDecoration(
                                                hintText: "Update Description",
                                                label: Text("Desc"),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              OutlinedButton(
                                                  onPressed: () async {
                                                    if (titilecontroller
                                                            .text.isNotEmpty &&
                                                        descController
                                                            .text.isNotEmpty) {
                                                      bool check = await dbHelper.updatenote(
                                                          title: titilecontroller.text.toString(),
                                                              desc: descController.text.toString(),
                                                              id: mData[index]["n_id"]);

                                                      if (check) {
                                                        Navigator.pop(context);
                                                        getNotes();
                                                      }
                                                    }
                                                  },
                                                  child: Text("Update")),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cansel")),
                                            ],
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(21)),
                                        color: Colors.white,
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                            bool check = await  dbHelper.deleatenote(id: mData[index]["n_id"]);
                            if(check){
                              getNotes();
                            }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Text('No notes Yet!!'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          titilecontroller.text = "";
          descController.clear();
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              // isDismissible: false, // for outside tab drag close
              enableDrag: false,
              context: context,
              builder: (_) {
                return Container(
                  padding: EdgeInsets.all(16),
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "ADD NOTE",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: titilecontroller,
                        decoration: InputDecoration(
                            label: Text("Title*"),
                            hintText: "Enter Title",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: descController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          label: Text("Description*"),
                          hintText: "Enter Desc....",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                if (titilecontroller.text.isNotEmpty &&
                                    descController.text.isNotEmpty) {
                                  bool check = await dbHelper.addNote(
                                      titile: titilecontroller.text.toString(),
                                      desc: descController.text.toString());

                                  if (check) {
                                    Navigator.pop(context);
                                    getNotes();
                                  }
                                }
                                ;
                              },
                              child: Text("Add")),
                          SizedBox(
                            width: 5,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cansel")),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
