import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostData extends StatefulWidget {
  const AddPostData({super.key});

  @override
  State<AddPostData> createState() => _AddPostDataState();
}

class _AddPostDataState extends State<AddPostData> {
  final databaseref = FirebaseDatabase.instance
      .ref('Post'); //will create a table of name post to store the data
  TextEditingController postController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add data'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: postController,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: 'Whats in your mind', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseref //databaseref.child(child).child(subchild).set... --to create the child of a child
                      .child(id)
                      .set({
                    'title': postController.text.toString(),
                    'id': id
                  }).then((value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Data Added')));
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  });
                  postController.text = '';
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
