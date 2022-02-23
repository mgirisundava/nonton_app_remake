import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/pages/movie_detail_page.dart';
import 'package:nonton_app/providers/see_all_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:nonton_app/widgets/shimmer_item.dart';
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
                    child: Container(
                      margin: EdgeInsets.only(
                        top: index == 0 || index == 1 ? 10 : 0,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: silverColor,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: seeAllProvider
                                          .seeAllMovies[index].backdropPath !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: seeAllProvider
                                          .seeAllMovies[index].posterPath!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const ShimmerItem(),
                                    )
                                  : Center(
                                      child: AutoSizeText(
                                        seeAllProvider
                                            .seeAllMovies[index].title!,
                                        style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: semiBold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxFontSize: 16,
                                        minFontSize: 16,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1 / 5,
                            height: MediaQuery.of(context).size.height * 1 / 18,
                            decoration: BoxDecoration(
                              color: lightBlackColor.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: orangeColor,
                                      size: 17,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    AutoSizeText(
                                      seeAllProvider
                                          .seeAllMovies[index].voteAverage
                                          .toString(),
                                      style:
                                          whiteTextStyle.copyWith(fontSize: 16),
                                      maxFontSize: 16,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: seeAllProvider.seeAllMoviesLength,
                ),
                onNotification: (notification) {
                  currentPage = currentPage + 1;
                  seeAllProvider.getSeeAllMovies(
                    movieCategory,
                    currentPage,
                  );
                  print('Add New Data');
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
