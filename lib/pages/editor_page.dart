import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditorPage extends StatefulWidget {
  final Map note;
  final int? index;

  EditorPage({required this.note, required this.index});

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note['title'] ?? '');
    _contentController = TextEditingController(text: widget.note['content'] ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void saveNote() {
    if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
      var newNote = {
        'title': _titleController.text,
        'content': _contentController.text,
      };

      if (widget.index == null) {
        Hive.box('notes').add(newNote);
      } else {
        Hive.box('notes').putAt(widget.index!, newNote);
      }
    }
    Navigator.pop(context);
  }

  void deleteNote() {
    if (widget.index != null) {
      Hive.box('notes').deleteAt(widget.index!);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.index == null ? 'New Note' : 'Edit Note'),
        actions: [
          if (widget.index != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteNote,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Start writing your note...',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.save),
        onPressed: saveNote,
      ),
    );
  }
}
