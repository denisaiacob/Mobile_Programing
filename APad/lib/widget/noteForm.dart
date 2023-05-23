import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

QuillController _controller = QuillController.basic();

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  NoteFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuillToolbar.basic(
                  controller: _controller,
                iconTheme: const QuillIconTheme(
                  borderRadius: 14,
                  iconSelectedFillColor: Colors.amberAccent,
                ),
              ),
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
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
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => QuillEditor(
    controller: _controller,
    readOnly: false,
    placeholder: 'Type something...',
    autoFocus: false,
    expands: false,
    padding: EdgeInsets.zero,
    focusNode: _focusNode,
    scrollable: true,
    scrollController: _scrollController,
  );

//       TextFormField(
//   maxLines: 50,
//   initialValue: description,
//   style: const TextStyle(color: Colors.black, fontSize: 18),
//   decoration: const InputDecoration(
//     border: InputBorder.none,
//     hintText: 'Type something...',
//     hintStyle: TextStyle(color: Colors.black),
//   ),
//   validator: (title) => title != null && title.isEmpty
//       ? 'The description cannot be empty'
//       : null,
//   onChanged: onChangedDescription,
// );
}