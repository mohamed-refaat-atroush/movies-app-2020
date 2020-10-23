import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_2020/providers/movie.dart';
import 'package:movies_app_2020/screens/movies_detail_screen.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieItem = Provider.of<Movie>(context);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MoviesDetailScreen(movieItem.id);
        }));
      },
      child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: const Radius.circular(15),
                      topLeft: const Radius.circular(15)),
                  child: Container(
                      constraints: const BoxConstraints(minHeight: 330),
                      child: Image.network(movieItem.imageUrl))),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 130,
                      child: Text(
                        movieItem.name,
                        overflow: TextOverflow.ellipsis,
                        //softWrap: true,
                      ),
                    ),
                    Text('rate:${movieItem.rate}'),
                    IconButton(
                        onPressed: () => movieItem.favoriteToggle(context),
                        icon: movieItem.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: const Color(0xff64FFDA),
                              )
                            : Icon(Icons.favorite_border,
                                color: const Color(0xff64FFDA)))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
