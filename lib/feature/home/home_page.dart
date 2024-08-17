import 'package:flutter/material.dart';
import 'package:movie_flutter/widget/favorite_movies/favorite_movies.dart';
import 'package:movie_flutter/widget/movie_showcase/movie_showcase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Discover',
            key: ValueKey('tab.discover'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            key: ValueKey('tab.favorites'),
          ),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (_selectedIndex == 0) {
      return const MovieShowcase();
    } else {
      return const FavoriteMovies();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
