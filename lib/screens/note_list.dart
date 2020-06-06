import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  NoteList({Key key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  
  int count = 1;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title : Text("Notes")
       ),
       body: getNoteListView(),
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           print("add");
         },
         child: Icon(
           Icons.add
         ),
       ),
    );
  }

  ListView getNoteListView(){

    TextStyle ts = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context,int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor : Colors.yellow,
            ),
            title : Text("ABC", style: ts,),
            subtitle: Text("11/11/11"),

            trailing: Icon(
              Icons.delete, 
              color:Colors.grey
            ),

            onTap: (){
              print("HI");
            },
          ),
        );
      }
    );
  }
}