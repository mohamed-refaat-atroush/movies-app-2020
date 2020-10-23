import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app_2020/providers/movies.dart';
import 'package:movies_app_2020/providers/movie.dart';

class MoviesDetailScreen extends StatelessWidget {
  final String id;
  const MoviesDetailScreen(this.id);
  @override
  Widget build(BuildContext context) {
    final allItems = Provider.of<Movies>(context).items;
    final Movie selectItem = allItems.firstWhere((movie) => movie.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectItem.name),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  constraints: const BoxConstraints(minHeight: 330),
                  child: Image.network(selectItem.imageUrl)),
              const SizedBox(
                height: 20,
              ),
              Text(
                selectItem.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(selectItem.type),
                  Text('rate:${selectItem.rate.toString()} ⭐'),
                  Text(selectItem.year.toString())
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                selectItem.description,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 2),
              )
            ],
          ),
        ],
      ),
    );
  }
}
