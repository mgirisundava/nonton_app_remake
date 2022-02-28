import 'package:flutter/material.dart';
import 'package:nonton_app/pages/movie_detail_page.dart';
import 'package:nonton_app/providers/see_all_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:nonton_app/widgets/poster_grid_item.dart';
import 'package:provider/provider.dart';

class SeeAllMoviesPage extends StatefulWidget {
  const SeeAllMoviesPage({Key? key}) : super(key: key);
  static const routeName = 'see-all-movies';

  @override
  State<SeeAllMoviesPage> createState() => _SeeAllMoviesPageState();
}

class _SeeAllMoviesPageState extends State<SeeAllMoviesPage> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final seeAllProvider = Provider.of<SeeAllProvider>(context, listen: false);
    final movieCategory = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text(
          movieCategory.toUpperCase(),
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: blackColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: seeAllProvider.getSeeAllMovies(movieCategory, 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text(
                'An error occured!',
                style: whiteTextStyle,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: NotificationListener<ScrollEndNotification>(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MovieDetailPage.routeName,
                        arguments: seeAllProvider.seeAllMovies[index].id,
                      );
                    },
                    child: PosterGridItem(
                      index: index,
                      posterPath: seeAllProvider.seeAllMovies[index].posterPath,
                      title: seeAllProvider.seeAllMovies[index].title!,
                      voteAverage:
                          seeAllProvider.seeAllMovies[index].voteAverage!,
                    ),
                  ),
                  itemCount: seeAllProvider.seeAllMoviesLength,
                ),
                onNotification: (notification) {
                  // currentPage = currentPage + 1;
                  // seeAllProvider.getSeeAllMovies(
                  //   movieCategory,
                  //   currentPage,
                  // );
                  // print('Add New Data');
                  return true;
                },
              ),
            );
          }
        },
      ),
    );
  }
}
