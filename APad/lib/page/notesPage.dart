import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../db/notesDatabase.dart';
import '../model/note.dart';
import '../widgets/noteCard.dart';
import 'DetailsNote.dart';
import 'CreateEditNote.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Notes',
        style: TextStyle(fontSize: 25,color: Colors.black),
      ),
    ),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : notes.isEmpty
          ? const Text(
        'No Notes',
        style: TextStyle(color: Colors.black, fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditNotePage()),
        );

        refreshNotes();
      },
    ),
  );

  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8),
    itemCount: notes.length,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    crossAxisCount: 2,
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(note: note),
      );
    },
  );
}