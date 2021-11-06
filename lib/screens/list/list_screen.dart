import 'package:dictionary_using_bloc/model/word_response.dart';
import 'package:dictionary_using_bloc/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<WordResponse> words;

  ListScreen(this.words);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: [
          Container(
            child: Text(
              'Search Result ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                    title: Text(
                      (index + 1).toString() + " " + words[index].word,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(words[index]),
                        ),
                      );
                    },
                  ),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
              itemCount: words.length),
        ],
      ),
    );
  }
}
