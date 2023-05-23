import 'package:apad/db/NoteDatabse.dart';
import 'package:apad/model/SavedNotes.dart';
import 'package:flutter/material.dart';

import 'EditorPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NoteDatabase noteDatabase=new NoteDatabase();
  List<SavedNotes> list=List<SavedNotes>.empty();

  @override
  Widget build(BuildContext context) {

    if(list.isEmpty==true){
      getData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (list.length).toString()
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          // bool result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditorPage(new SavedNotes(""))));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditorPage(new SavedNotes(""))));

          // if(result==true){
          //   getData();
          // }
        },
        backgroundColor: Colors.grey[100],
        child: const Icon(Icons.add,color: Colors.black,),
      ),
    );
  }

  void getData() {
    final dbFuture=noteDatabase.initDatabase();
    dbFuture.then((result){
      final Notes=noteDatabase.getNotes();
      Notes.then((result){
        List<SavedNotes> tempList=List<SavedNotes>.empty();
        int count=result.length;
        for(int i=0;i<count;i++){
          tempList.add(SavedNotes.FromObject(result[i]));
        }
        setState(() {
          list=tempList;
        });
      });
    });
  }
}
