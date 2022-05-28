import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://analisisproyecto.azurewebsites.net/api/Notes";

  Future<dynamic> _getListado() async {
    final respuesta = await get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      return jsonDecode(respuesta.body);
    } else {
      print("Error con la respusta");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Listado API"),
        ),
        body: FutureBuilder<dynamic>(
            future: _getListado(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot);
                return ListView(children: listado(snapshot.data));
              } else {
                print("No hay información");
                return Text("Sin data");
              }
            }));
  }

  List<Widget> listado(List<dynamic> info) {
    List<Widget> lista = [];
    info.forEach((elemento) {
      lista.add(Text("Id: " + elemento["id"].toString()));
      lista.add(Text("Título: " + elemento["title"].toString()));
      lista.add(Text("Descripción: " + elemento["description"].toString()));
      lista.add(Text(""));
    });
    return lista;
  }
}
