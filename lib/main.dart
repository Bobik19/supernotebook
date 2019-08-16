import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class Note {
  int id;
  String title;
  String text;
  Note({this.title = "", this.text = "", this.id = -1});
}

List<Note> noteList = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: noteList.length == 0
          ? Center(
              child: Text("Nothing now", style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w800),),
            )
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  
                  leading: Icon(Icons.note),
                  title: Text(noteList[index].title),
                  trailing: IconButton(icon: Icon(Icons.delete_forever), onPressed: () {setState(() {
                noteList.removeAt(index);
              }); }, ),
                  onTap: () {
                    noteList[index].id = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPage(
                                  note: noteList[index],
                                )));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pages),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPage(
                        note: Note(),
                      )));
                      
        },
      ),
      
    );
  }
}

class EditPage extends StatefulWidget {
  Note note;
  EditPage({this.note});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController;

  TextEditingController textController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note.title);
    textController = TextEditingController(text: widget.note.text);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.lightBlue,
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: "Title"),
            controller: titleController,
          ),
          TextField(
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Your note'),
            controller: textController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int id = widget.note.id;
          if (id == -1) {
            noteList.add(
                Note(title: titleController.text, text: textController.text));
          } else {
            noteList.insert(
                id,
                Note(
                    title: titleController.text,
                    text: textController.text,
                    id: id));
            noteList.removeAt(id + 1);
          }
          Navigator.pop(context);
        },
        child: Icon(Icons.save_alt),
      ),
    );
  }
}