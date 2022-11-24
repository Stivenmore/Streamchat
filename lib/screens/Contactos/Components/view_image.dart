import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  final String url;
  const ViewImage({required this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: FadeInImage.assetNetwork(
          placeholderScale: 100,
          placeholder: 'assets/placeholder.jpg',
          image: url,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}