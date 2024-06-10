import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditorPage extends StatefulWidget {
  final Map note;
  final int? index;

  const EditorPage({Key? key, required this.note, required this.index}) : super(key: key);

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('notes');
    _titleController = TextEditingController(text: widget.note['title']);
    _contentController = TextEditingController(text: widget.note['content']);
  }

  void _saveNote() {
    var newNote = {
      'title': _titleController.text,
      'content': _contentController.text,
    };

    if (widget.index == null) {
      box.add(newNote);
    } else {
      box.putAt(widget.index!, newNote);
    }

    Navigator.pop(context);
  }

  void _deleteNote() {
    if (widget.index != null) {
      box.deleteAt(widget.index!);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Changed AppBar color
        title: Text('Edit Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
          if (widget.index != null) // Show delete button only for existing notes
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteNote,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey), // Changed hint text color
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Content',
                  hintStyle: TextStyle(color: Colors.grey), // Changed hint text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
