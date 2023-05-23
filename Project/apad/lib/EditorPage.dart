import 'dart:convert';

import 'package:apad/db/NoteDatabse.dart';
import 'package:apad/model/SavedNotes.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';


NoteDatabase noteDatabase = NoteDatabase();
class EditorPage extends StatefulWidget{
  SavedNotes _savedNotes;
  EditorPage(this._savedNotes);

  @override
  State<StatefulWidget> createState()=>createNote(_savedNotes);
}

class createNote extends State<EditorPage>{
  SavedNotes _notes;
  createNote(this._notes);

  late quill.QuillController _controller;
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notepad")
        ),
        body:Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          quill.QuillToolbar.basic(
            controller: _controller,
            iconTheme: const quill.QuillIconTheme(
              borderRadius: 14,
              iconSelectedFillColor: Colors.amberAccent,
            ),
          ),
          quill.QuillEditor(
            controller: _controller,
            readOnly: false,
            placeholder: 'Type something...',
            autoFocus: false,
            expands: false,
            padding: EdgeInsets.zero,
            focusNode: _focusNode,
            scrollable: true,
            scrollController: _scrollController,
          ),
          // buildTitle(),
          // const SizedBox(height: 8),
          // // buildDescription(),
          // const SizedBox(height: 16),
        ],
      )),
      floatingActionButton: Builder(
        builder: (BuildContext context ){
          return FloatingActionButton(
            child: Icon(Icons.save),
            backgroundColor: Colors.green[300],
            onPressed: (){
              save();
            },
          );
        },
      ),
    );
  }

@override
void initState() {
  super.initState();
  _controller = quill.QuillController.basic();
  _focusNode = FocusNode();
  _scrollController = ScrollController();
}

void save(){
  var content=jsonEncode(_controller.document.toDelta().toJson());
  debugPrint(content.toString());
  _notes.content=content;
  if(_notes.id==null){
    //ceva
  }
  else{
    noteDatabase.insertNote(_notes);
  }
  // Navigator.pop(context,true);
}


//   NotusDocument _loadDocument() {
//     Delta delta=Delta()..insert("Insert text here\n");
//     return NotusDocument.fromDelta(delta);
// }
}
