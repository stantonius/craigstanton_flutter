import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BlogDetail extends StatelessWidget {
  final Map data;

  const BlogDetail({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data['title'],
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
              Expanded(
                  child: Markdown(
                controller: controller,
                selectable: true,
                data: data['blogfile'],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
