import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trakt_dart/trakt_dart.dart';
import 'package:trakt_sample/secret.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final secret = await SecretLoader(secretPath: "secrets.json").load();
  runApp(TraktDartApp(secret: secret));
}

// ignore: must_be_immutable
class TraktDartApp extends StatelessWidget {
  late TraktManager traktManager;
  final Secret secret;

  TraktDartApp({Key? key, required this.secret}) : super(key: key) {
    // Replace with your clientId and clientId from Trakt API.
    traktManager = TraktManager(
        clientId: secret.clientId,
        clientSecret: secret.clientSecret,
        redirectURI: "");

    traktManager.authentication.generateDeviceCodes(signup: true).then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
  }

  Future<List<TrendingMovie>> getTrendingMovies() {
    return traktManager.movies.getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
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
            return ListView.builder(
              itemCount: trendingMovies.length,
              itemBuilder: (context, index) {
                final movie = trendingMovies[index];
                return Text(movie.movie.title);
              },
            );
          },
        ),
      ),
    );
  }
}
