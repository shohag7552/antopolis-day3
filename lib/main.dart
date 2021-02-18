import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Shop> shopData = [];
  Shop items;
  //Shop shop;
  Future loadJson() async {
    var url =
        "https://forkify-api.herokuapp.com/api/search?q=pizza&fbclid=IwAR1dhC55CheHciSdJLhT0KllRO0wVqTSJYKv-7V2ZOs4y5cq8tXPl56iLls#";
    var result = await http.get(url);

    if (result.statusCode == 200) {
      final jsonResponce = json.decode(result.body);

      print(jsonResponce);
      items = Shop.fromJson(jsonResponce);

      print('................');
      print(items);
      setState(() {
        shopData.add(items);
      });
    }

    final jsonResponce = json.decode(result.body);

    print(jsonResponce);
    items = Shop.fromJson(jsonResponce);

    print('................');
    print(items);
    setState(() {
        shopData.add(items);
      });
  }

  @override
  void initState() {
    loadJson();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shopData.isEmpty
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: ListView.builder(
                itemCount: items.recipes.length,
                itemBuilder: (context, index) {
                  //var data = shopData[index];
                  return ListTile(
                    title: Text(items.recipes[index].title),
                    subtitle: Text(items.recipes[index].publisher),
                  );
                },
              ),
            ),
    );
  }
}
