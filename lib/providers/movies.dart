import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
import 'package:movies_app_2020/helpers/db_helper.dart';

class Movies with ChangeNotifier {
  List<Movie> _items = [];
  List<Movie> get items {
    return [..._items];
  }

  List<Movie> _favoriteItemDp = [];

  List<Movie> get favoriteItemDp {
    return _favoriteItemDp;
  }

  Future<void> fetchAndSetMovies() async {
    final dataList = await DBHelper.getData('favorite_movies');
    _favoriteItemDp = dataList
        .map(
          (item) => Movie(
              id: item['id'],
              name: item['title'],
              imageUrl: item['image'],
              description: item['description'],
              rate: item['rate'],
              year: item['year'],
              type: item['type']),
        )
        .toList();
    notifyListeners();
  }

  Future<void> fetchMoviesData({int page}) async {
    var url =
        'https://api.themoviedb.org/3/trending/all/day?api_key=51b713587433a8ad90ce37236fa5eca4&page=$page';

    final response = await http.get(url).catchError((error) {
      throw error;
    });
    final extractedData = json.decode(response.body)['results'];

    for (var moviesData in extractedData) {
      _items.add(Movie(
        name: moviesData['title'] ?? 'null',
        id: moviesData['id'].toString() ?? 'c1',
        description: moviesData['overview'] ?? 'null',
        year: moviesData['release_date'] ?? '2020',
        type: moviesData['media_type'] ?? 'null',
        rate: moviesData['vote_average'] ?? 1,
        imageUrl: 'https://image.tmdb.org/t/p/w500${moviesData['poster_path']}' ??
            'https://cdn3.vectorstock.com/i/1000x1000/30/12/abstract-geometric-background-black-and-white-vector-10383012.jpg',
      ));
    }

    notifyListeners();
  }

  clearList() {
    _items.clear();
  }

  test() {
    _items.add(Movie(
        id: '1',
        name: 'lo',
        description: 'can',
        rate: 2,
        year: '10',
        type: 'ac',
        imageUrl:
            'https://blog.mascotaysalud.com/wp-content/uploads/2019/07/dogo-argentino-mascota-salud.jpg'));
  }
}
