import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String imgFull;
  DetailScreen({this.imgFull});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFeec183),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Unsplash Gallery",
              style: TextStyle(fontFamily: 'GreatVibes', fontSize: 35.0)),
          backgroundColor: Color(0xFFc39e6b),
        ),
        body: Container(
          child: GestureDetector(
            onTap: () => Navigator.pop,
            child: Container(
                child: Image(
              image: NetworkImage(imgFull),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red[200],
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            )),
          ),
        ));
  }
}
