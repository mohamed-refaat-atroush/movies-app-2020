import 'package:flutter/cupertino.dart';
import 'package:movies_app_2020/helpers/db_helper.dart';

class Movie with ChangeNotifier {
  @required
  final String id;
  @required
  final String name;
  @required
  final String imageUrl;
  @required
  final String description;
  @required
  final double rate;
  @required
  final String year;
  final String type;
  bool isFavorite;

  Movie({
    this.id,
    this.name,
    this.description,
    this.rate,
    this.year,
    this.imageUrl,
    this.type,
    this.isFavorite = false,
  });
  Future<void> favoriteToggle(BuildContext context) async {
    isFavorite = !isFavorite;
    if (isFavorite) {
      await DBHelper.insert('favorite_movies', {
        'id': id,
        'title': name,
        'image': imageUrl,
        'description': description,
        'rate': rate,
        'type': type,
        'year': year,
      });
    } else {
      DBHelper.delete(id);

      notifyListeners();
    }

    notifyListeners();
  }
}
