import 'package:flutter/material.dart';
/*Este es el punto de entrada a la app, haciendo la llamada runApp pasandole como parametro nuestra futura App*/
void main() => runApp(MyApp());

/*Comenzamos a definir una pantalla básica donde será un Stateless Widget*/
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //El titulo de la aplicación
      title: 'Bienvenido a Flutter',
      home: Scaffold(
        appBar: AppBar(
          // El texto que aparecerá en la barra superior
          title: Text('Taller InforSanLuis-Flutter 2019'),
        ),
        body: Center(
          // El texto que aparecerá en el centro de nuestra pantalla.
          child: Text('Hello World'),
        ),
      ),
    );
  }
}