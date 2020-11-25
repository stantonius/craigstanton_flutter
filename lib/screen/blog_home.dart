import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/models/const_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import main template and homepage class
import '../utils/templates/main_screen_template.dart';

class BlogHomeScreen extends StatelessWidget {
  const BlogHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(BlogHome());
  }
}

/*
Note on layout building with a ListView widget. There is an issue when nesting
ListView in 2 columns. Apparently ListView needs to explicitly send the height
of the space avaiable to its children. So you need to wrap ListView in an Expanded
widget, which itself is embedded in a Column widget. However if there is a Column 
widget higher up in the tree you need to ensure it has a defined space (done by
wrapping it in Padding widget) 
*/

// Code references FlutterFire https://firebase.flutter.dev/docs/firestore/usage/
// and creates lists with different types of items https://flutter.dev/docs/cookbook/lists/mixed-list

// BlogPage is the main Widget that returns a ListView (BlogList) once the Firestore
// Query has connected and returned data
// BlogPage is a copy of the example in FlutterFire ref with the excption of
// of BlogList widget and returning QuerySnapshot in the Future builder

class BlogHome extends StatelessWidget {
  const BlogHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference getBlogs =
        FirebaseFirestore.instance.collection('blog_dev');

    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(children: [
        Padding(
          padding: ResponsiveLayout.isSmallScreen(context)
              ? const EdgeInsets.only(top: 20.0)
              : const EdgeInsets.only(top: 120.0),
          child: Row(
            children: [
              Spacer(
                flex: 1,
              ),
              Expanded(
                  flex: ResponsiveLayout.isSmallScreen(context) ? 8 : 5,
                  child: FutureBuilder<QuerySnapshot>(
                    future: getBlogs.orderBy('date', descending: true).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        List docs = snapshot.data.docs;
                        // BlogList returns a ListView once connection and data is successful
                        return Container(
                          child: BlogList(
                              items: List<ListItem>.generate(docs.length,
                                  (index) => BlogItem(docs[index]))),
                        );
                      }

                      return Text("loading");
                    },
                  )),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ]),
    );
  }
}

// The Widgets below allow for returning different types of widgets depending on content
class BlogList extends StatelessWidget {
  final List<ListItem> items;

  const BlogList({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Container(
            child: ListTile(
              //title: item.buildTitle(context),
              //subtitle: item.buildSubtitle(context),
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              trailing: item.buildDate(context),
              selected: true,
              focusColor: Colors.blueGrey,
              hoverColor: Colors.grey,
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/blogdetail', arguments: item.getData());
              },
            ),
          );
        });
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);

  /// Return the date and (eventually) topics
  Widget buildDate(BuildContext context);

  // Get the data of the blog
  getData();
}

/// A ListItem that contains data to display a heading.
class BlogItem implements ListItem {
  // Note the change of the datatype to DocumentSnapshot
  final DocumentSnapshot blog;

  BlogItem(this.blog);

  Widget buildTitle(BuildContext context) {
    return Text(
      blog.data()['title'],
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget buildSubtitle(BuildContext context) => Text(blog.data()['description'],
      style: Theme.of(context).textTheme.bodyText2);

  Widget buildDate(BuildContext context) {
    //final date= new DateTime.fromMillisecondsSinceEpoch(blog.data['date']);
    String dateFormatted =
        new DateFormat('yyyy-MM-dd').format(blog.data()['date'].toDate());
    return Text(dateFormatted);
  }

  getData() {
    return blog.data();
  }
}
