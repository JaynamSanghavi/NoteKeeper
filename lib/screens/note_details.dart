import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notekeeper/models/note.dart';
import 'package:notekeeper/utils/DatabaseHelper.dart';
import 'dart:async';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  Note note;
  NoteDetail(this.note,this.appBarTitle,{Key key}) : super(key: key);
  @override
  _NoteDetailState createState() => _NoteDetailState(this.note,this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  
  String appBarTitle = "";
  Note note;
  static var _priorities = ['High','Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  _NoteDetailState(this.note,this.appBarTitle);

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String updatePriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.desc = descriptionController.text;
  }

  void save() async {
    moveToLastScreen();
    note.date =
        DateFormat.yMMMd().format(DateTime.now()); // Sets the current date

    int result;
    if (note.id != null) {
      // Update operation
      result = await databaseHelper.update(note);
    } else {
      // Insert operation
      result = await databaseHelper.insert(note);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved successfully');
    } else {
      _showAlertDialog('Status', 'Error saving note, Please try again later');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  void delete() async {
    moveToLastScreen();
    if (note.id == null) {
      _showAlertDialog('Status', 'No note was deleted');
      return;
    } else {
      int result = await databaseHelper.delete(note.id);
      if (result != 0) {
        _showAlertDialog('Status', 'Note Deleted Successfully');
      } else {
        _showAlertDialog('Status',
            'Error occurred while deleting note, please try again later');
      }
    }
  }


  void moveToLastScreen(){
    Navigator.pop(context,true);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle ts = Theme.of(context).textTheme.subtitle1;
    titleController.text = note.title;
    descriptionController.text = note.desc;

    return Scaffold(
      appBar: AppBar(
        title : Text(appBarTitle),
      ),

      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownStringItem){
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: ts,
                value: updatePriorityAsString(note.priority),
                onChanged: (valueSelectByUser){
                  setState(() {
                    updatePriorityAsInt(valueSelectByUser);
                  });
                },

              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,bottom:10),
              child: TextField(
                controller: titleController,
                onChanged: (val){
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText : 'Title',
                  border : OutlineInputBorder(
                    borderRadius : BorderRadius.circular(5),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,bottom:10),
              child: TextField(
                controller: descriptionController,
                onChanged: (val){
                  updateDescription();
                },
                decoration: InputDecoration(
                  labelText : 'Description',
                  border : OutlineInputBorder(
                    borderRadius : BorderRadius.circular(5),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,bottom:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Save",
                      ),
                      onPressed: (){
                        setState(() {
                          print("Save");
                          save();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width : 20.0
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Delete",
                      ),
                      onPressed: (){
                        setState(() {
                          print("Delete");
                          delete();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),



    );
  }
}