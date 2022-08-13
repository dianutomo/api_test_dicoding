import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:api_test/album.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Album> futureFunction;

// url: https://jsonplaceholder.typicode.com/albums/1
  Future<Album> fetchAlbum() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/albums/1"),
    );
    if (response.statusCode == 200) {
      return Album.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw "Error";
    }
  }

  @override
  void initState() {
    super.initState();
    futureFunction = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Album>(
            future: futureFunction,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            })),
      ),
    );
  }
}
