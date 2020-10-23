import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_2020/providers/movies.dart';
import 'package:movies_app_2020/widget/favoritItem.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Movies>(context, listen: false).fetchAndSetMovies(),
        builder: (context, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Movies>(
                child: Center(
                  child: const Text('Empty , start adding some!'),
                ),
                builder: (ctx, greatMovies, ch) =>
                    greatMovies.favoriteItemDp.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatMovies.favoriteItemDp.length,
                            itemBuilder: (ctx, i) => FavoriteItem(
                              id: greatMovies.favoriteItemDp[i].id,
                              imageUrl: greatMovies.favoriteItemDp[i].imageUrl,
                              name: greatMovies.favoriteItemDp[i].name,
                              year: greatMovies.favoriteItemDp[i].year,
                            ),
                          ),
              ));
  }
}
