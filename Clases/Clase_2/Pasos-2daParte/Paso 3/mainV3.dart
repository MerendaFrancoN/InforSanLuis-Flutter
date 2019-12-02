import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(title: 'Bienvenido a Flutter', home: RandomWords());
	}
}

class RandomWords extends StatefulWidget {
	@override
	RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
	final _sugerencias = <WordPair>[];
	final _fuenteLista = const TextStyle(fontSize: 18.0);
	final _favoritos = Set<WordPair>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Taller InforSanLuis-Flutter 2019'),
				actions: <Widget>[
					// Add 3 lines from here...
					IconButton(icon: Icon(Icons.list), onPressed: _pushView),
				],
			),
			body: _buildSugerencias());
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
		final bool isInFavoritos = _favoritos.contains(palabra); /* 1 */

		return Column(
			children: <Widget>[
				ListTile(
					title: Text(
						palabra.asPascalCase,
						style: _fuenteLista,
					),
					trailing: Icon(
						/* 2 */
						isInFavoritos ? Icons.favorite : Icons.favorite_border,
						/* 3 */
						color: isInFavoritos ? Colors.red : null, /* 4 */
					),
					onTap: () {
						setState(() {
							if (isInFavoritos)
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

	void _pushView() {
		Navigator.of(context)
			.push(MaterialPageRoute(builder: (BuildContext context) {

				final Iterable<ListTile> tiles = _favoritos.map(

					// 1° Mapeando a cada palabra, el encerrarla en un ListTile
						(WordPair palabra) {
						return ListTile(
							title: Text(
								palabra.asPascalCase,
								style: _fuenteLista,
							),
						);
					});

					// 2° Armamos la lista de widget con los separadores
				final List<Widget> divided = ListTile.divideTiles(
					context: context ,
					tiles: tiles
				).toList();


				return Scaffold(
					appBar: AppBar(
						title: Text("Lista de Favoritos"),
					),
					body: ListView(children: divided,),
				);
			})
		);
	}
}

