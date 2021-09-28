import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'full_screen_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic urlData;

  void getApiData() async {
    dynamic url = Uri.parse(
        "https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9");

    final res = await http.get(url);
    setState(() {
      urlData = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        centerTitle: true,
      ),
      body: Center(
        child: urlData == null
            ? const CircularProgressIndicator()
            : GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(url: urlData[i]['urls']['full']),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'full$i',
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        urlData[i]['urls']['full']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text("Author" " : " +
                                urlData[i]["user"]['name'].toString()),
                            Text("Picture" " : " + urlData[i]['id'].toString())
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
