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
  final _favoritos = Set<WordPair>();



  @override
  Widget build(BuildContext context) {
    return _buildSugerencias();
  }

  Widget _buildSugerencias() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {

          if (i >= _sugerencias.length) {
            _sugerencias.addAll(generateWordPairs().take(10));
          }
          return _buildPalabra(_sugerencias[i]);
        });
  }



  Widget _buildPalabra(WordPair palabra) {

    final bool isInFavoritos = _favoritos.contains(palabra);          /* 1 */

    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            palabra.asPascalCase,
            style: _fuenteLista,
          ),

          trailing: Icon(                                             /* 2 */
            isInFavoritos ? Icons.favorite : Icons.favorite_border,   /* 3 */
            color: isInFavoritos ? Colors.red : null,                 /* 4 */
          ),
          onTap: (){
            setState(() {
              if(isInFavoritos)
                _favoritos.remove(palabra);
              else
                _favoritos.add(palabra);
            });
          },
        ),
        Divider(),
      ],
    );
  }

}

