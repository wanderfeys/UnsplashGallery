import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tutorial_http/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List loadDataa = [];
  List<String> imgUrl = [];
  List<String> textDescription = [];
  List<String> detailUrl = [];
  List<String> likeArray = [];
  bool showImg = false;

  Future<dynamic> getImg() async {
    const url =
        'https://api.unsplash.com/photos/?client_id=Jgw7-8yiQ5zzsGU0oUqzXdbT3zNWpbqYf_23ROaj-ww';
    var response = await http.get(url);
    loadDataa = jsonDecode(response.body);
    _assign();
    _textAssign();
    _detaiAssign();
    setState(() {
      showImg = true;
    });
  }

  _assign() {
    for (var i = 0; i < loadDataa.length; i++) {
      imgUrl.add(loadDataa.elementAt(i)['urls']['small']);
    }
  }

  _detaiAssign() {
    for (var i = 0; i < loadDataa.length; i++) {
      detailUrl.add(loadDataa.elementAt(i)['urls']['full']);
    }
  }

  _textAssign() {
    for (var i = 0; i < loadDataa.length; i++) {
      textDescription.add(loadDataa.elementAt(i)['alt_description']);
      likeArray.add(loadDataa.elementAt(i)['likes'].toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getImg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeec183),
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.photo_library),
        title: Text(
          "Unsplash Gallery",
          style: TextStyle(fontFamily: 'GreatVibes', fontSize: 35.0),
        ),
        backgroundColor: Color(0xFFc39e6b),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: loadDataa.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => DetailScreen(
                              imgFull: detailUrl.elementAt(index),
                            ));
                    Navigator.push(context, route);
                  },
                  child: Card(
                    child: !showImg
                        ? CircularProgressIndicator()
                        : Image(
                            image: NetworkImage(imgUrl.elementAt(index)),
                            fit: BoxFit.cover,
                            height: 350,
                            width: 500,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${textDescription.elementAt(index).toString()},   Like: ${likeArray.elementAt(index).toString()}',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'KaushanScript'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
