import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nonton_app/pages/movie_detail_page.dart';
import 'package:nonton_app/pages/see_all_movies_page.dart';
import 'package:nonton_app/pages/see_all_tv_page.dart';
import 'package:nonton_app/pages/tv_detail_page.dart';
import '../providers/all_trending_provider.dart';
import '../providers/movies_provider.dart';
import '../providers/tv_provider.dart';
import '../theme.dart';
import 'package:provider/provider.dart';
import '../widgets/card_item.dart';
import '../widgets/carousel_card_item.dart';
import '../widgets/see_all_text.dart';
import '../widgets/shimmer_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _trendingTabController;
  late TabController _topRatedTabController;

  late Future _allTrendingFuture;
  Future obtainAllTrendingFuture() {
    return Provider.of<AllTrendingProvider>(context, listen: false)
        .getAllTrendingProvider();
  }

  late Future _nowPlayingMoviesFuture;
  Future obtainNowPlayingMoviesFuture() {
    return Provider.of<MoviesProvider>(context, listen: false)
        .getNowPlayingMovies();
  }

  late Future _tvOnTvFuture;
  Future obtainTvOnTvFuture() {
    return Provider.of<TvProvider>(context, listen: false).getTvOnTv();
  }

  late Future _popularMoviesFuture;
  Future obtainPopularMoviesFuture() {
    return Provider.of<MoviesProvider>(context, listen: false)
        .getPopularMovies();
  }

  late Future _tvPopularFuture;
  Future obtainTvPopularFuture() {
    return Provider.of<TvProvider>(context, listen: false).getTvPopular();
  }

  late Future _topRatedMoviesFuture;
  Future obtainTopRatedMoviesFuture() {
    return Provider.of<MoviesProvider>(context, listen: false)
        .getTopRatedMovies();
  }

  late Future _tvTopRatedFuture;
  Future obtainTvTopRatedFuture() {
    return Provider.of<TvProvider>(context, listen: false).getTvTopRated();
  }

  late Future _upcomingMoviesFuture;
  Future obtainUpcomingMoviesFuture() {
    return Provider.of<MoviesProvider>(context, listen: false)
        .getUpcomingMovies();
  }

  @override
  void initState() {
    super.initState();
    _trendingTabController = TabController(length: 2, vsync: this);
    _topRatedTabController = TabController(length: 2, vsync: this);
    _allTrendingFuture = obtainAllTrendingFuture();
    _nowPlayingMoviesFuture = obtainNowPlayingMoviesFuture();
    _tvOnTvFuture = obtainTvOnTvFuture();
    _popularMoviesFuture = obtainPopularMoviesFuture();
    _tvPopularFuture = obtainTvPopularFuture();
    _topRatedMoviesFuture = obtainTopRatedMoviesFuture();
    _tvTopRatedFuture = obtainTvTopRatedFuture();
    _upcomingMoviesFuture = obtainUpcomingMoviesFuture();
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final tvProvider = Provider.of<TvProvider>(context, listen: false);
    final allTrendingProvider =
        Provider.of<AllTrendingProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: blackColor,
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 3.5,
            child: FutureBuilder(
              future: _allTrendingFuture,
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
                  return CarouselSlider.builder(
                    itemCount: 15,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 1 / 3.5,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        GestureDetector(
                      onTap: () {
                        allTrendingProvider.allTrending[itemIndex].mediaType ==
                                'movie'
                            ? Navigator.pushNamed(
                                context,
                                MovieDetailPage.routeName,
                                arguments: allTrendingProvider
                                    .allTrending[itemIndex].id,
                              )
                            : allTrendingProvider
                                        .allTrending[itemIndex].mediaType ==
                                    'tv'
                                ? Navigator.pushNamed(
                                    context,
                                    TvDetailPage.routeName,
                                    arguments: allTrendingProvider
                                        .allTrending[itemIndex].id,
                                  )
                                : null;
                      },
                      child: Container(
                        color: greyColor,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            allTrendingProvider
                                        .allTrending[itemIndex].backdropPath !=
                                    null
                                ? SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: allTrendingProvider
                                          .allTrending[itemIndex].backdropPath!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const ShimmerItem(),
                                    ),
                                  )
                                : const Center(
                                    child: Icon(Icons.image),
                                  ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 1 / 20,
                                color: lightBlackColor.withOpacity(0.8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    AutoSizeText(
                                      allTrendingProvider
                                          .allTrending[itemIndex].title!,
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: semiBold,
                                      ),
                                      maxFontSize: 18,
                                      minFontSize: 18,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

// ignore: todo
// TODO : NOW PLAYING

          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 5),
            child: AutoSizeText(
              'Now Playing',
              style:
                  whiteTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              maxFontSize: 20,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TabBar(
            indicatorColor: orangeColor,
            labelStyle:
                whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            indicatorWeight: 3,
            controller: _trendingTabController,
            tabs: const <Widget>[
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'TV Shows',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 250,
            child: TabBarView(
              controller: _trendingTabController,
              children: <Widget>[
// ignore: todo
// TODO : NOW PLAYING MOVIES

                FutureBuilder(
                  future: _nowPlayingMoviesFuture,
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
                      return CarouselSlider.builder(
                        itemCount: 15,
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: 0.5,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            CarouselCardItem(
                          isMovie: true,
                          id: moviesProvider.nowPlayingMovies[itemIndex].id,
                          imageUrl: moviesProvider
                              .nowPlayingMovies[itemIndex].posterPath,
                          voteAverage: moviesProvider
                              .nowPlayingMovies[itemIndex].voteAverage
                              .toString(),
                        ),
                      );
                    }
                  },
                ),

// ignore: todo
// TODO : NOW PLAYING TV SHOWS

                FutureBuilder(
                  future: _tvOnTvFuture,
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
                      return Center(
                        child: CarouselSlider.builder(
                          itemCount: 15,
                          options: CarouselOptions(
                            height: 250,
                            viewportFraction: 0.5,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              CarouselCardItem(
                            isMovie: false,
                            id: tvProvider.tvOnTv[itemIndex].id,
                            imageUrl: tvProvider.tvOnTv[itemIndex].posterPath,
                            voteAverage: tvProvider
                                .tvOnTv[itemIndex].voteAverage
                                .toString(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),

// ignore: todo
// TODO : POPULAR MOVIE

          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              right: 10,
              bottom: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Popular Movies',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  maxFontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SeeAllMoviesPage.routeName,
                      arguments: 'popular',
                    );
                  },
                  child: const SeeAllText(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 225,
            child: FutureBuilder(
              future: _popularMoviesFuture,
              builder: (context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moviesProvider.popularMoviesLength <= 6
                      ? moviesProvider.popularMoviesLength
                      : 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 10 : 0,
                        right: 10,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailPage.routeName,
                            arguments: moviesProvider.popularMovies[index].id,
                          );
                        },
                        child: CardItem(
                          id: moviesProvider.popularMovies[index].id,
                          title: moviesProvider.popularMovies[index].title,
                          posterPath:
                              moviesProvider.popularMovies[index].posterPath,
                          voteAverage: moviesProvider
                              .popularMovies[index].voteAverage
                              .toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

// ignore: todo
// TODO : POPULAR TV SHOWS

          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              right: 10,
              bottom: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Popular TV Shows',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  maxFontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SeeAllTvPage.routeName,
                      arguments: 'popular',
                    );
                  },
                  child: const SeeAllText(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 225,
            child: FutureBuilder(
              future: _tvPopularFuture,
              builder: (context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvProvider.tvPopularLength <= 6
                      ? tvProvider.tvPopularLength
                      : 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 10 : 0,
                        right: 10,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailPage.routeName,
                            arguments: tvProvider.tvPopular[index].id,
                          );
                        },
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              TvDetailPage.routeName,
                              arguments: tvProvider.tvPopular[index].id,
                            );
                          },
                          child: CardItem(
                            id: tvProvider.tvPopular[index].id,
                            title: tvProvider.tvPopular[index].name,
                            posterPath: tvProvider.tvPopular[index].posterPath,
                            voteAverage: tvProvider.tvPopular[index].voteAverage
                                .toString(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

// ignore: todo
// TODO : TOP RATED

          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'Top Rated',
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Image.asset(
                        'assets/images/medali.png',
                        width: 28,
                        height: 28,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Divider(
                    thickness: 3,
                    color: orangeColor,
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            indicatorColor: orangeColor,
            indicatorWeight: 3,
            labelStyle:
                whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            controller: _topRatedTabController,
            tabs: const <Widget>[
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'TV Shows',
              ),
            ],
          ),

          SizedBox(
            height: 270,
            child: TabBarView(
              controller: _topRatedTabController,
              children: <Widget>[
// ignore: todo
// TODO : TOP RATED MOVIES

                FutureBuilder(
                  future: _topRatedMoviesFuture,
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
                      return ListView.builder(
                        primary: false,
                        itemCount: 3,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MovieDetailPage.routeName,
                                arguments:
                                    moviesProvider.topRatedMovies[index].id,
                              );
                            },
                            child: TopRatedCardItem(
                              id: moviesProvider.topRatedMovies[index].id,
                              index: index,
                              title:
                                  moviesProvider.topRatedMovies[index].title!,
                              posterPath: moviesProvider
                                  .topRatedMovies[index].posterPath,
                              releaseDate: moviesProvider
                                  .topRatedMovies[index].releaseDate!,
                              voteAverage: moviesProvider
                                  .topRatedMovies[index].voteAverage!,
                            ),
                          );
                        }),
                      );
                    }
                  },
                ),

// ignore: todo
// TODO : TOP RATED TV SHOWS

                FutureBuilder(
                  future: _tvTopRatedFuture,
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
                      return ListView.builder(
                        primary: false,
                        itemCount: 3,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                TvDetailPage.routeName,
                                arguments: tvProvider.tvTopRated[index].id,
                              );
                            },
                            child: TopRatedCardItem(
                              id: tvProvider.tvTopRated[index].id,
                              index: index,
                              title: tvProvider.tvTopRated[index].name!,
                              posterPath:
                                  tvProvider.tvTopRated[index].posterPath,
                              releaseDate:
                                  tvProvider.tvTopRated[index].firstAirDate!,
                              voteAverage:
                                  tvProvider.tvTopRated[index].voteAverage!,
                            ),
                          );
                        }),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

// ignore: todo
// TODO : UPCOMING MOVIE

          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              right: 10,
              bottom: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Upcoming Movies',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  maxFontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SeeAllMoviesPage.routeName,
                      arguments: 'upcoming',
                    );
                  },
                  child: const SeeAllText(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 225,
            child: FutureBuilder(
              future: _upcomingMoviesFuture,
              builder: (context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moviesProvider.upcomingMoviesLength <= 6
                      ? moviesProvider.upcomingMoviesLength
                      : 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 10 : 0,
                        right: 10,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailPage.routeName,
                            arguments: moviesProvider.upcomingMovies[index].id,
                          );
                        },
                        child: CardItem(
                          id: moviesProvider.upcomingMovies[index].id,
                          title: moviesProvider.upcomingMovies[index].title,
                          posterPath:
                              moviesProvider.upcomingMovies[index].posterPath,
                          voteAverage: moviesProvider
                              .upcomingMovies[index].voteAverage
                              .toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

// ignore: todo
// TODO : TOP RATED CARD ITEM

class TopRatedCardItem extends StatelessWidget {
  final int id;
  final int index;
  final String title;
  final String? posterPath;
  final num voteAverage;
  final DateTime releaseDate;
  const TopRatedCardItem({
    Key? key,
    required this.id,
    required this.index,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: lightBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: index == 0
                  ? goldColor
                  : index == 1
                      ? silverColor
                      : index == 2
                          ? bronzeColor
                          : lightBlackColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: AutoSizeText(
                '${index + 1}',
                style: blackTextStyle.copyWith(
                  color: index == 0
                      ? blackColor
                      : index == 1
                          ? blackColor
                          : index == 2
                              ? blackColor
                              : whiteColor,
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
                maxFontSize: 16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 50,
            height: double.infinity,
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: posterPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: posterPath!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerItem(),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.image),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  title,
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  maxFontSize: 16,
                  minFontSize: 16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(
                  DateFormat('yyyy').format(
                    releaseDate,
                  ),
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  maxFontSize: 14,
                  minFontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.star,
                  size: 15,
                  color: orangeColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                AutoSizeText(
                  voteAverage.toString(),
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                  ),
                  maxFontSize: 14,
                  minFontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
