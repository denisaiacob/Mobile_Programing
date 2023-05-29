import 'dart:convert';

import 'package:flutter/material.dart';
import '../db/notesDatabase.dart';
import '../model/note.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  // late String description;
  late quill.QuillController _controller;
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    title = widget.note?.title ?? '';

    if (widget.note?.description !=null){
    _controller = quill.QuillController(
          document: quill.Document.fromJson(jsonDecode(widget.note!.description)),
          selection: TextSelection.collapsed(offset: 0),
        );
    }else{
      _controller=quill.QuillController.basic();
    }

    _focusNode = FocusNode();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: backButton(),
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child:Padding(
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
          const SizedBox(height: 5),
          TextFormField(
            maxLines: 1,
            initialValue: title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.black),
              ),
            validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
            onChanged:(value){ title=value;},
          ),
          const SizedBox(height: 8),
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
        ],
      )),
    ),
  );

  Widget backButton() => IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: Colors.black,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor:Colors.green[200],
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    var content=jsonEncode(_controller.document.toDelta().toJson());
    final note = widget.note!.copy(
      title: title,
      description: content,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    var content=jsonEncode(_controller.document.toDelta().toJson());
    final note = Note(
      title: title,
      description: content,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}