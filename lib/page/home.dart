import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trakt_dart/trakt_dart.dart';

class HomePage extends StatelessWidget {
  final TraktManager traktManager;

  const HomePage({required this.traktManager, Key? key}) : super(key: key);

  Future<List<TrendingMovie>> getTrendingMovies() {
    return traktManager.movies.getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: FutureBuilder<List<TrendingMovie>>(
        future: getTrendingMovies(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final trendingMovies = snapshot.data!;
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    traktManager.authentication
                        .generateDeviceCodes()
                        .then((resp) {
                      context.goNamed("auth", extra: resp);
                    });
                  },
                  child: const Text("Autorizza")),
              Expanded(
                child: ListView.builder(
                  itemCount: trendingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = trendingMovies[index];
                    return Text(movie.movie.title);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
