import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_2020/providers/movies.dart';
import 'package:movies_app_2020/widget/movie_item.dart';
import 'package:provider/provider.dart';
import 'package:movies_app_2020/providers/movie.dart';

class MoviesOverviewScreen extends StatefulWidget {
  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  void _showAlertDialog(String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('An Error Occurred!'),
              content: Text(text),
              actions: [
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  ScrollController _scrollController = new ScrollController();
  int _from = 5;
  int _to = 10;
  bool _isLoop = true;
  @override
  void initState() {
    Provider.of<Movies>(context, listen: false).clearList();
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _isLoop) {
        setState(() {
          Provider.of<Movies>(context, listen: false)
              .fetchMoviesData(from: _from, to: _to)
              .then((value) {
            setState(() {
              _from += 5;
              _to += 5;
              if (_to > 20) {
                setState(() {
                  _isLoop = false;
                });
              }
            });
          }).catchError((error) {
            _showAlertDialog('check your Internet');
          });
        });
      }
    });
  }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Movies>(context, listen: false)
          .fetchMoviesData(from: 0, to: 5)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        _showAlertDialog('some thing go wrong');
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> moviesList =
        Provider.of<Movies>(context, listen: false).items;

    return _isLoading
        ? Center(
            child: Text('loading...'),
          )
        : ListView.builder(
            controller: _scrollController,
            itemCount: moviesList.length,
            itemBuilder: (context, i) {
              return ChangeNotifierProvider.value(
                  value: moviesList[i], child: MovieItem());
            });
  }
}
