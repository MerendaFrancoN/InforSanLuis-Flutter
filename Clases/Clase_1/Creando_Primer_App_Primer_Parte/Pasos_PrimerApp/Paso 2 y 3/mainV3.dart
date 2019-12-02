import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Bienvenido a Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Taller InforSanLuis-Flutter 2019'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}


class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}


class RandomWordsState extends State<RandomWords>{

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }

}
