import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  NoteDetail(this.appBarTitle,{Key key}) : super(key: key);
  @override
  _NoteDetailState createState() => _NoteDetailState(this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  
  String appBarTitle = "";
  static var _priorities = ['High','Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  _NoteDetailState(this.appBarTitle);

  // void moveToLastScreen(){
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    TextStyle ts = Theme.of(context).textTheme.subtitle1;
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
                value: 'Low',
                onChanged: (valueSelectByUser){
                  setState(() {
                    print(valueSelectByUser);
                  });
                },

              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:10,bottom:10),
              child: TextField(
                controller: titleController,
                onChanged: (val){
                  print(val);
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
                  print(val);
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