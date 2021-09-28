import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  dynamic url;
  FullScreenImage({Key? key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'thumb',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
