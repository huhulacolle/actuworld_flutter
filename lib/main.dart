import 'dart:convert';

import 'package:actuworld_flutter/article.dart';
import 'package:actuworld_flutter/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[800]!),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article>? articles;

  @override
  void initState() {
    super.initState();
    getArticle();
  }

  AlertDialog alert = const AlertDialog(
    title: Text("Erreur"),
    content: Text("Aucun article trouvé."),
  );

  Future<void> getArticle() async {
    const endPointUrl =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=73ce7275f8134bee9e9d0399d2ae3314";
    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      setState(() {
        articles = (json['articles'] as List<dynamic>)
            .map((item) => Article.fromJson(item))
            .toList();
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: articles == null ? 0 : articles!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => News(
                  article: articles![index],
                ),
              ),
            ),
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(articles![index].title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge), // Remplacez par votre titre // Remplacez par votre description
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
