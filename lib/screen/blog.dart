import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Code references FlutterFire https://firebase.flutter.dev/docs/firestore/usage/
// and creates lists with different types of items https://flutter.dev/docs/cookbook/lists/mixed-list

// BlogPage is the main Widget that returns a ListView (BlogList) once the Firestore
// Query has connected and returned data
// BlogPage is a copy of the example in FlutterFire ref with the excption of
// of BlogList widget and returning QuerySnapshot in the Future builder
class BlogPage extends StatelessWidget {
  const BlogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference getBlogs = Firestore.instance.collection('blog_dev');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Blogs',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  Row(children: [
                    FutureBuilder<QuerySnapshot>(
                      future: getBlogs.getDocuments(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          List docs = snapshot.data.documents;
                          // BlogList returns a ListView once connection and data is successful
                          return BlogList(
                              items: List<ListItem>.generate(docs.length,
                                  (index) => BlogItem(docs[index])));
                        }

                        return Text("loading");
                      },
                    )
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The Widgets below allow for returning different types of widgets depending on content
class BlogList extends StatelessWidget {
  final List<ListItem> items;

  const BlogList({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Container(
                    color: Colors.red,
                    child: ListTile(
                      //title: item.buildTitle(context),
                      //subtitle: item.buildSubtitle(context),
                      title: item.buildTitle(context),
                      subtitle: item.buildSubtitle(context),
                    ),
                  );
                }),
          ),
        ],
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class BlogItem implements ListItem {
  // Note the change of the datatype to DocumentSnapshot
  final DocumentSnapshot blog;

  BlogItem(this.blog);

  Widget buildTitle(BuildContext context) {
    return Text(
      blog.data['title'],
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget buildSubtitle(BuildContext context) => Text(blog.data['description'],
      style: Theme.of(context).textTheme.bodyText2);
}
