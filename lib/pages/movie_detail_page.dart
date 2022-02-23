import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nonton_app/pages/person_detail_page.dart';
import 'package:nonton_app/pages/see_all_credits_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/credit_item.dart';
import '../widgets/rating_and_popularity_item.dart';
import '../widgets/no_review_item.dart';
import '../widgets/review_item.dart';
import '../widgets/see_all_text.dart';
import '../widgets/shimmer_item.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../providers/movie_detail_provider.dart';
import '../widgets/genre_item.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  static const routeName = 'movie-detail';

  @override
  Widget build(BuildContext context) {
    final movieDetailProvider =
        Provider.of<MovieDetailProvider>(context, listen: false);
    final movieId = ModalRoute.of(context)!.settings.arguments as int;

    void _launchUrl(String url) async => await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';

    return Scaffold(
      backgroundColor: blackColor,
      body: FutureBuilder(
        future: movieDetailProvider.getMovieDetail(movieId),
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
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: blackColor,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: MediaQuery.of(context).size.height * 1 / 2,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: greyColor,
                          child: movieDetailProvider
                                      .movieDetail['backdrop_path'] !=
                                  null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original' +
                                          movieDetailProvider
                                              .movieDetail['backdrop_path'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const ShimmerItem(),
                                )
                              : const Center(
                                  child: Icon(Icons.image),
                                ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
// ignore: todo
// TODO : LINK TO YOUTUBE

                            const Spacer(),
                            FutureBuilder(
                              future:
                                  movieDetailProvider.getMovieVideo(movieId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                  return movieDetailProvider.movieVideo.isEmpty
                                      ? const SizedBox()
                                      : InkWell(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: () {
                                            _launchUrl(
                                                'https://www.youtube.com/watch?v=' +
                                                    movieDetailProvider
                                                        .movieVideo[0].key);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1 /
                                                9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1 /
                                                9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color:
                                                  whiteColor.withOpacity(0.8),
                                            ),
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: blackColor,
                                            ),
                                          ),
                                        );
                                }
                              },
                            ),
                            const Spacer(),

// ignore: todo
// TODO : TITLE & INFO

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 220,
                                color: lightBlackColor.withOpacity(0.8),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      width: 120,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: greyColor,
                                      ),
                                      child: movieDetailProvider
                                                  .movieDetail['poster_path'] !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500' +
                                                        movieDetailProvider
                                                                .movieDetail[
                                                            'poster_path'],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const ShimmerItem(),
                                              ),
                                            )
                                          : const Center(
                                              child: Icon(Icons.image),
                                            ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            movieDetailProvider
                                                    .movieDetail['title'] ??
                                                movieDetailProvider.movieDetail[
                                                    'original_title'],
                                            style: whiteTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: semiBold,
                                            ),
                                            maxFontSize: 18,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 10),
                                          DetailText(
                                            title: 'Duration : ',
                                            value:
                                                '${movieDetailProvider.movieDetail['runtime']} min',
                                          ),
                                          DetailText(
                                            title: 'Status : ',
                                            value: movieDetailProvider
                                                .movieDetail['status'],
                                          ),
                                          DetailText(
                                            title: 'Release Date : ',
                                            value: DateFormat('MMM dd, yyyy')
                                                .format(
                                              DateTime.parse(
                                                movieDetailProvider.movieDetail[
                                                    'release_date'],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
// ignore: todo
// TODO : LIST OF GENRES

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieDetailProvider.movieGenresLength,
                          itemBuilder: (context, index) => GenreItem(
                            index: index,
                            name: movieDetailProvider.movieGenres[index].name,
                          ),
                        ),
                      ),

// ignore: todo
// TODO : RATING AND BUDGET

                      RatingAndPopularityItem(
                        voteAverage:
                            movieDetailProvider.movieDetail['vote_average'],
                        voteCount:
                            movieDetailProvider.movieDetail['vote_count'],
                        popularity:
                            movieDetailProvider.movieDetail['popularity'],
                      ),

// ignore: todo
// TODO : DESCRIPTION

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: AutoSizeText(
                          'Description',
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                          maxFontSize: 18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ReadMoreText(
                          movieDetailProvider.movieDetail['overview'] == ''
                              ? 'No Description'
                              : movieDetailProvider.movieDetail['overview'],
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            height: 1.5,
                          ),
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          colorClickableText: orangeColor,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                        ),
                      ),

// ignore: todo
// TODO : REVIEWS

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: AutoSizeText(
                          'Review',
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                          maxFontSize: 18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 4,
                        child: FutureBuilder(
                          future: movieDetailProvider.getMovieReview(movieId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                              return movieDetailProvider.movieReview.isEmpty
                                  ? const NoReviewItem()
                                  : CarouselSlider.builder(
                                      itemCount:
                                          movieDetailProvider.movieReviewLength,
                                      options: CarouselOptions(
                                        height: double.infinity,
                                        viewportFraction: 1.0,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                      itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int pageViewIndex) =>
                                          ReviewItem(
                                        author: movieDetailProvider
                                            .movieReview[itemIndex].author,
                                        content: movieDetailProvider
                                            .movieReview[itemIndex].content,
                                        url: movieDetailProvider
                                            .movieReview[itemIndex].url,
                                      ),
                                    );
                            }
                          },
                        ),
                      ),

// ignore: todo
// TODO : CREDITS

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'Credit',
                              style: whiteTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                              maxFontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    SeeAllCreditsPage.routeName,
                                    arguments: [movieId, 'movie'],
                                  );
                                },
                                child: const SeeAllText()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                          future: movieDetailProvider.getMovieCredit(movieId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                              return movieDetailProvider.movieCredit.isEmpty
                                  ? Center(
                                      child: AutoSizeText(
                                        'No Data',
                                        style: greyTextStyle,
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movieDetailProvider
                                                  .movieCreditLength <=
                                              8
                                          ? movieDetailProvider
                                              .movieCreditLength
                                          : 8,
                                      itemBuilder: ((context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            left: index == 0 ? 10 : 0,
                                            right: 10,
                                          ),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                PersonDetailPage.routeName,
                                                arguments: movieDetailProvider
                                                    .movieCredit[index].id,
                                              );
                                            },
                                            child: CreditItem(
                                              imageUrl: movieDetailProvider
                                                  .movieCredit[index]
                                                  .profilePath,
                                              name: movieDetailProvider
                                                  .movieCredit[index].name,
                                              character: movieDetailProvider
                                                  .movieCredit[index].character,
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// ignore: todo
// TODO : DETAIL TEXT

class DetailText extends StatelessWidget {
  final String? title, value;
  const DetailText({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          title!,
          style: greyTextStyle.copyWith(
            fontSize: 16,
          ),
          maxFontSize: 16,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AutoSizeText(
          value!,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
          ),
          maxFontSize: 16,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
