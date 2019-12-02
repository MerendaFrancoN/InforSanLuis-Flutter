/*
Taller de InforSanLuis - 2019
Diseñando y Desarrollando aplicaciones con Flutter

Colaboradores:
  * Maguire, Margarita
  * Decena, Facundo M.
  * Pellegrino, Maximiliano H.
  * Merenda, Franco N.

Codigo de ejemplo para hacer una llamada a una API y mostrarlo por pantalla.
Se logra a través del uso de un FutureBuilder

 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'usuario.dart';

//Punto de entrada a la App
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Usuario>> _listaDeUsuarios;

  @override
  void initState() {
    super.initState();
    _listaDeUsuarios = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de llamada a API'),
        ),
        body: Center(
          child: FutureBuilder<List<Usuario>>(
            future: _listaDeUsuarios,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //Si hay datos, muestro la lista de usuarios
                return listOfUsersUI(snapshot.data);
              } else if (snapshot.hasError) {
                //Si hubo error, muestro el error en un text
                return Text("${snapshot.error}");
              }

              //Por defecto muestro una espera circular
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<List<Usuario>> fetchUsers() async {
  //Hacemos un GET de una api en particular, en este caso usamos la API de reqres.in
  final response = await http.get('https://reqres.in/api/users?page=2');

  final List<Usuario> listaPosts = List();

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.

    //Decodificamos la respuesta con el paquete json que trae Dart
    var bodyDecodificado = json.decode(response.body);

    //Obtenemos una lista de los usuarios que nos provee la API,
    // abir https://reqres.in/api/users?page=2 en el navegador,
    // y veremos que es lo que estamos decodificando


    //Creamos una lista de objetos a partir del body
    var listaDeUsuarios = List.from(bodyDecodificado['data']);

    //Creamos la lista de Usuarios a partir del JSON.
    for (dynamic object in listaDeUsuarios) {
      listaPosts.add(Usuario.fromJson(object));
    }

    return listaPosts;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Falla en obtener datos desde la API');
  }
}

Widget listOfUsersUI(List<Usuario> listaDeUsuarios) {
  return ListView.separated(
    separatorBuilder: (context, index) => Divider(
      color: Colors.black,
    ),
    itemCount: listaDeUsuarios.length,
    itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8.0),
        child: _buildUserItem(listaDeUsuarios
            .elementAt(index)) //Center(child: Text("Index $index")),
        ),
  );
}

//La idea es que a partir de este código de ejemplo, lo hagan ver más bonito.
Widget _buildUserItem(Usuario usuario) {
  return Row(
    children: <Widget>[
      Container(
        height: 64,
        width: 64,
        child: FadeInImage(
            placeholder: AssetImage("assets/user.png"),
            image: NetworkImage(usuario.avatarURL)),
      ),
      Column(
        children: <Widget>[
          Text("${usuario.firstName} ${usuario.lastName}"),
          Text(usuario.email)
        ],
      ),
    ],
  );
}
