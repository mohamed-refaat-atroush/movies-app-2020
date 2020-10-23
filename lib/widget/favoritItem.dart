import 'package:flutter/material.dart';
import 'package:movies_app_2020/helpers/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:movies_app_2020/providers/movies.dart';

class FavoriteItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String year;
  final String id;
  const FavoriteItem({this.id, this.name, this.year, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    void _alertDialog(String itemName) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Alert!'),
                content: Text(
                    'Are you sure delete $itemName Film from favorite List'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      //moviesProvider.removeFavorite(id);s
                      DBHelper.delete(id);
                      Provider.of<Movies>(context, listen: false)
                          .fetchAndSetMovies();
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ));
    }

    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        title: Text(name),
        subtitle: Text(year),
        trailing: IconButton(
          onPressed: () {
            _alertDialog(name);
          },
          icon: const Icon(
            Icons.delete,
            color: const Color(0xff64FFDA),
          ),
        ),
      ),
    );
  }
}
