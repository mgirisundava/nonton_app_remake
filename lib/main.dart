import 'package:flutter/material.dart';
import 'package:nonton_app/pages/home_page.dart';
import 'package:nonton_app/pages/movie_detail_page.dart';
import 'package:nonton_app/pages/person_detail_page.dart';
import 'package:nonton_app/pages/see_all_movies_page.dart';
import 'package:nonton_app/pages/tv_detail_page.dart';
import 'package:nonton_app/providers/all_trending_provider.dart';
import 'package:nonton_app/providers/movie_detail_provider.dart';
import 'package:nonton_app/providers/movies_provider.dart';
import 'package:nonton_app/providers/people_detail_provider.dart';
import 'package:nonton_app/providers/see_all_provider.dart';
import 'package:nonton_app/providers/tv_detail_provider.dart';
import 'package:nonton_app/providers/tv_provider.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TvProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllTrendingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TvDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonDetailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SeeAllProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          MovieDetailPage.routeName: (context) => const MovieDetailPage(),
          TvDetailPage.routeName: (context) => const TvDetailPage(),
          PersonDetailPage.routeName: (context) => const PersonDetailPage(),
          SeeAllMoviesPage.routeName: (context) => const SeeAllMoviesPage(),
        },
      ),
    );
  }
}
