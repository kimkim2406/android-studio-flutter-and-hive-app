import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'note_mini.dart';
import 'editor_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Changed background color
      appBar: AppBar(
        backgroundColor: Colors.teal, // Changed AppBar color
        title: Text('My Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box box, _) {
                if (box.values.isEmpty) {
                  return Center(
                    child: Text(
                      'No Notes Yet!',
                      style: TextStyle(fontSize: 24, color: Colors.teal), // Changed text color
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      var note = box.getAt(index);
                      return ListTile(
                        title: Text(
                          note['title'] ?? 'No Title',
                          style: TextStyle(fontSize: 20, color: Colors.teal), // Changed text color
                        ),
                        subtitle: Text(note['content'] ?? 'No Content', maxLines: 1, overflow: TextOverflow.ellipsis),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditorPage(note: note, index: index)),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal, // Changed button color
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditorPage(note: {}, index: null)),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '© 2024 Keltoum Hamaidi. All rights reserved.',
          style: TextStyle(color: Colors.teal),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
