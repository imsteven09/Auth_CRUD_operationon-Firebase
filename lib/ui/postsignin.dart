import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:operationsonfirebase/core/constants/color_constant.dart';
import 'package:operationsonfirebase/core/constants/string_constant.dart';
import 'package:operationsonfirebase/core/constants/textstyle_constant.dart';
//import 'package:flutter/widgets.dart';
import 'package:operationsonfirebase/ui/adddata.dart';
import 'package:operationsonfirebase/ui/signin_page.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  TextEditingController searchController = TextEditingController();
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstant.Welcome,
          style: TextStyleConstant.welcomeappbar,
        ),
        backgroundColor: ColorConstants.welcomeappbar,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SigninPage();
                  }));
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              },
              icon: const Icon(
                Icons.logout,
                color: ColorConstants.white,
              )),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              StringConstant.withfirebaseanimatedlist,
              style: TextStyleConstant.withfirebaseanimatedlist,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: searchController,
                onChanged: (String value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    hintText: StringConstant.search,
                    border: OutlineInputBorder()),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  //indbuild list feature of firebasedatabase
                  query: ref,
                  defaultChild: const Text('loading'),
                  itemBuilder: (context, snapshot, animation, index) {
                    final title =
                        snapshot.child(StringConstant.title).value.toString();

                    if (searchController.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot
                            .child(StringConstant.title)
                            .value
                            .toString()),
                        subtitle: Text(
                            'ID ${snapshot.child(StringConstant.id).value.toString()}'),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialogue(
                                        title,
                                        snapshot
                                            .child(StringConstant.id)
                                            .value
                                            .toString());
                                  },
                                  leading: const Icon(Icons.edit),
                                  title: const Text(StringConstant.edit),
                                )),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(snapshot
                                            .child(StringConstant.id)
                                            .value
                                            .toString())
                                        .remove();
                                  },
                                  leading: const Icon(Icons.delete),
                                  title: const Text(StringConstant.delete),
                                ))
                          ],
                        ),
                      );
                    } else if (title.toLowerCase().contains(
                        searchController.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snapshot
                            .child(StringConstant.title)
                            .value
                            .toString()),
                        subtitle: Text(
                            snapshot.child(StringConstant.id).value.toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialogue(
                                        title,
                                        snapshot
                                            .child(StringConstant.id)
                                            .value
                                            .toString());
                                  },
                                  leading: const Icon(Icons.edit),
                                  title: const Text(StringConstant.edit),
                                )),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);

                                    ref
                                        .child(snapshot
                                            .child(StringConstant.id)
                                            .value
                                            .toString())
                                        .remove()
                                        .then((value) {
                                      print('success');
                                    }).onError((error, stackTrace) {
                                      print(error.toString());
                                    });
                                  },
                                  leading: const Icon(Icons.delete),
                                  title: const Text(StringConstant.delete),
                                ))
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),

            //with stream builder
            // Divider(),
            // Text('With StreamBuilder'),
            // Expanded(
            //     child: StreamBuilder(
            //   stream: ref.onValue,
            //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //     if (!snapshot.hasData) {
            //       return CircularProgressIndicator();
            //     } else {
            //       Map<dynamic, dynamic> map =
            //           snapshot.data!.snapshot.value as dynamic;
            //       List<dynamic> list = [];
            //       list.clear();
            //       list = map.values.toList();
            //       return ListView.builder(
            //           itemCount: snapshot.data!.snapshot.children.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               title: Text(list[index]['title']),
            //               subtitle: Text(list[index]['id']),
            //             );
            //           });
            //     }
            //   },
            // ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.adddata,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddPostData();
          }));
        },
        child: const Icon(
          Icons.add,
          color: ColorConstants.white,
        ),
      ),
    );
  }

  Future<void> showMyDialogue(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(StringConstant.update),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: const InputDecoration(
                    hintText: StringConstant.edit,
                    border: OutlineInputBorder()),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(StringConstant.cancel)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .child(id)
                        .update({'title': editController.text}).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(StringConstant.dataupdated)));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    });
                  },
                  child: const Text(StringConstant.update))
            ],
          );
        });
  }
}


//with firebase animated list

// Expanded(
//             child: FirebaseAnimatedList(
//                 //indbuild list feature of firebasedatabase
//                 query: ref,
//                 defaultChild: Text('loading'),
//                 itemBuilder: (context, snapshot, animation, index) {

                  
//         return ListTile(
          //           title: Text(snapshot.child('title').value.toString()),
          //           subtitle: Text(snapshot.child('id').value.toString()),
          //         );
          //       }),
          // ),