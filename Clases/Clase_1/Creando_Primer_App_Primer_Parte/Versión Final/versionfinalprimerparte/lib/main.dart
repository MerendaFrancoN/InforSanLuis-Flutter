import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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

  final _sugerencias = <WordPair>[];
  final _fuenteLista = const TextStyle(fontSize: 18.0);



  @override
  Widget build(BuildContext context) {
    return _buildSugerencias();
  }

  Widget _buildSugerencias() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0), /*1*/
        itemBuilder: /*1*/ (context, i) {

          if (i >= _sugerencias.length) {
            _sugerencias.addAll(generateWordPairs().take(10)); /*2*/
          }
          return _buildPalabra(_sugerencias[i]); /*3*/
        });
  }



  Widget _buildPalabra(WordPair palabra) {
    return Column(                          /*5*/
      children: <Widget>[
        ListTile(
          title: Text(
            palabra.asPascalCase,           /*6*/
            style: _fuenteLista,            /*7*/
          ),
        ),
        Divider(),                          /*8*/
      ],
    );
  }

}




