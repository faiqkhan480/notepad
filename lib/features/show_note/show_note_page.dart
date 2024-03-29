import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:libv_markdown/libv_markdown.dart';

import 'package:rx_notifier/rx_notifier.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:notepad/features/show_note/show_note_controller.dart';

class ShowNoteActivity extends StatefulWidget {
  int noteId;
  ShowNoteActivity(this.noteId, {Key? key}) : super(key: key);

  @override
  _ShowNoteActivityState createState() => _ShowNoteActivityState();
}

class _ShowNoteActivityState extends State<ShowNoteActivity> {
  late ShowNoteController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShowNoteController();
    _controller.selectNoteFromDatabase(id: widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RxBuilder(builder: (_) => Text(_controller.note.value.title)),
        backgroundColor: const Color(0xff111822),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scrollbar(
          child: RxBuilder(
            builder: (context) =>
                MarkdownView(
                  markdownViewHTML: _controller.note.value.description,
                ),
            // Markdown(data: _controller.note.value.description,),
          ),
        ),
      ),
    );
  }
}
