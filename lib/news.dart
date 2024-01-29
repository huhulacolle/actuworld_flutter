import 'package:actuworld_flutter/article.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({super.key, required this.article});

  final Article article;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  Future<void> onPressed() async {
      if (!await launchUrl(Uri.parse(widget.article.url))) {
    throw Exception('Could not launch $widget.article.url');
  }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.article.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.network(widget.article.urlToImage),
              const SizedBox(height: 20),
              Text(
                widget.article.description,
              ),
              const SizedBox(height: 20),
              TextButton(onPressed: onPressed, child: const Text("Voir l'articles")),
            ],
          ),
        ),
      ),
    );
  }
}
