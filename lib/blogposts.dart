import 'package:flutter/material.dart';
import 'files.dart';
import 'package:vibration/vibration.dart';

class BlogPosts extends StatefulWidget{
  const BlogPosts({super.key, required this.username});
  final String username;

  @override
  State<BlogPosts> createState() => BlogPostState();
}

Future<List> getBlogPosts() {
  return readBlogs();
}

class BlogPostState extends State<BlogPosts> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  bool write = false;
  List blogNames = [];
  List blogLocations = [];
  List blogDescs = [];
  List blogAuthors = [];

  @override
  void initState() {
    super.initState();
    _showPosts();
  }

  void _writePost() {
    Vibration.vibrate(duration: 25);
    setState(() {
      write = true;
    });
  }

  void _submitPost() {
    writeToBlogs(titleController.text, locationController.text, descController.text, widget.username);
    setState(() {
      write = false;
    });
    _showPosts();
  }

  void _showPosts() async {
    Vibration.vibrate(duration: 25);
    blogNames.clear();
    blogLocations.clear();
    blogDescs.clear();
    blogAuthors.clear();
    List posts = await readBlogs();
    setState(() {
      write = false;
      for (int i=0; i<posts.length;i++) {
        List post = posts[i].split(",");
        if (post.length == 4) {
          blogNames.add(post[0]);
          blogLocations.add(post[1]);
          blogDescs.add(post[2]);
          blogAuthors.add(post[3]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context){
    if (write) {
      return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFA7E2E3), Color(0xFF2D728F),],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView( // removes overflow when keyboard is open
                    child: Column(
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Text('Add a post',
                                style: TextStyle(fontSize: 56, color: Color(
                                    0xFFFFFFFF), fontWeight: FontWeight.bold),),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  labelText: "Post Title",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a title.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: locationController,
                                decoration: const InputDecoration(
                                  labelText: "Location",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a location.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: descController,
                                decoration: const InputDecoration(
                                  labelText: "Description",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a description.";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _submitPost();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
        floatingActionButton: FloatingActionButton(
        onPressed: _showPosts,
          backgroundColor: Colors.white,
          child: const Icon(Icons.arrow_back, color: Color(0xFF2D728F),),
      ),
      );
    } else {
      return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFA7E2E3), Color(0xFF2D728F),],
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    children: [
                      Text('Posts', style: TextStyle(fontSize: 56, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),),
                      Flexible (
                        child: ListView.separated (
                            padding: const EdgeInsets.all(8),
                            itemCount: blogNames.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                child: Center(
                                    child: Column(
                                      children: [
                                        Text('Title: ${blogNames[i]}'),
                                        Text('Author: ${blogAuthors[i]}'),
                                        Text('Location: ${blogLocations[i]}'),
                                        Text('Description: ${blogDescs[i]}')
                                      ],
                                    )
                                )
                              );
                            }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                        )
                      )
                    ]
                ),
              ),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: _writePost,
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, color: Color(0xFF2D728F),),
        ),
      );
    }
  }
}