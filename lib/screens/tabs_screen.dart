import 'package:flutter/material.dart';
import 'package:movies_app_2020/screens/favorite_screen.dart';
import 'package:movies_app_2020/screens/movies_overview_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTabs = 0;
  List<Map<String, Object>> _page;
  @override
  void initState() {
    _page = [
      {'page': MoviesOverviewScreen(), 'title': 'All Movies'},
      {'page': FavoriteScreen(), 'title': 'Favorite Movies'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectedTabs]['title']),
      ),
      body: _page[_selectedTabs]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabs,
        onTap: (val) {
          setState(() {
            _selectedTabs = val;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.movie), title: const Text('All')),
          BottomNavigationBarItem(
              icon: _selectedTabs == 1
                  ? const Icon(
                      Icons.favorite,
                      color: const Color(0xff64FFDA),
                    )
                  : const Icon(Icons.favorite_border,
                      color: const Color(0xff64FFDA)),
              title: const Text('Favorite'))
        ],
      ),
    );
  }
}
