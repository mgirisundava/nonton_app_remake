import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nonton_app/pages/person_detail_page.dart';
import 'package:nonton_app/providers/tv_detail_provider.dart';
import 'package:nonton_app/widgets/see_all_text.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';
import '../widgets/credit_item.dart';
import '../widgets/genre_item.dart';
import '../widgets/no_review_item.dart';
import '../widgets/rating_and_popularity_item.dart';
import '../widgets/review_item.dart';
import '../widgets/shimmer_item.dart';

class TvDetailPage extends StatelessWidget {
  const TvDetailPage({Key? key}) : super(key: key);

  static const routeName = 'tv-detail';

  @override
  Widget build(BuildContext context) {
    final tvDetailProvider =
        Provider.of<TvDetailProvider>(context, listen: false);
    final tvId = ModalRoute.of(context)!.settings.arguments as int;

    void _launchUrl(String url) async => await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';

    return Scaffold(
      backgroundColor: blackColor,
      body: FutureBuilder(
        future: tvDetailProvider.getTvDetail(tvId),
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
                          child:
                              tvDetailProvider.tvDetail['backdrop_path'] != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original' +
                                              tvDetailProvider
                                                  .tvDetail['backdrop_path'],
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
                              future: tvDetailProvider.getTvVideo(tvId),
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
                                  return tvDetailProvider.tvVideo.isEmpty
                                      ? const SizedBox()
                                      : InkWell(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: () {
                                            _launchUrl(
                                              'https://www.youtube.com/watch?v=' +
                                                  tvDetailProvider
                                                      .tvVideo[0].key,
                                            );
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
                                      child: tvDetailProvider
                                                  .tvDetail['poster_path'] !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500' +
                                                        tvDetailProvider
                                                                .tvDetail[
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
                                            tvDetailProvider.tvDetail['name'] ??
                                                tvDetailProvider
                                                    .tvDetail['original_name'],
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
                                            title: 'Seasons : ',
                                            value:
                                                '${tvDetailProvider.tvDetail['number_of_seasons']}',
                                          ),
                                          DetailText(
                                            title: 'Status : ',
                                            value: tvDetailProvider
                                                .tvDetail['status'],
                                          ),
                                          DetailText(
                                            title: 'First Air Date : ',
                                            value: DateFormat('MMM dd, yyyy')
                                                .format(
                                              DateTime.parse(
                                                tvDetailProvider
                                                    .tvDetail['first_air_date'],
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
                          itemCount: tvDetailProvider.tvGenresLength,
                          itemBuilder: (context, index) => GenreItem(
                            index: index,
                            name: tvDetailProvider.tvGenres[index].name,
                          ),
                        ),
                      ),

// ignore: todo
// TODO : RATING AND BUDGET

                      RatingAndPopularityItem(
                        voteAverage: tvDetailProvider.tvDetail['vote_average'],
                        voteCount: tvDetailProvider.tvDetail['vote_count'],
                        popularity: tvDetailProvider.tvDetail['popularity'],
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
                          tvDetailProvider.tvDetail['overview'] == ''
                              ? 'No Description'
                              : tvDetailProvider.tvDetail['overview'],
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
// TODO : SEASONS INFORMATION

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Seasons',
                              style: whiteTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                              maxFontSize: 18,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SeeAllText(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tvDetailProvider.tvSeasonsLength <= 3
                              ? tvDetailProvider.tvSeasonsLength
                              : 3,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? 10 : 0,
                                right: 10,
                              ),
                              child: TvSeasonItem(
                                name: tvDetailProvider.tvSeasons[index].name,
                                posterPath: tvDetailProvider
                                    .tvSeasons[index].posterPath,
                                episode: tvDetailProvider
                                    .tvSeasons[index].episdoeCount,
                                airDate:
                                    tvDetailProvider.tvSeasons[index].airDate,
                              ),
                            );
                          }),
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
                          future: tvDetailProvider.getTvReview(tvId),
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
                              return tvDetailProvider.tvReview.isEmpty
                                  ? const NoReviewItem()
                                  : CarouselSlider.builder(
                                      itemCount:
                                          tvDetailProvider.tvReviewLength,
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
                                        author: tvDetailProvider
                                            .tvReview[itemIndex].author,
                                        content: tvDetailProvider
                                            .tvReview[itemIndex].content,
                                        url: tvDetailProvider
                                            .tvReview[itemIndex].url,
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
                              onTap: () {},
                              child: const SeeAllText(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                          future: tvDetailProvider.getTvCredit(tvId),
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
                              return tvDetailProvider.tvCredit.isEmpty
                                  ? Center(
                                      child: AutoSizeText(
                                        'No Data',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                        maxFontSize: 14,
                                        minFontSize: 14,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          tvDetailProvider.tvCreditLength <= 8
                                              ? tvDetailProvider.tvCreditLength
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
                                                arguments: tvDetailProvider
                                                    .tvCredit[index].id,
                                              );
                                            },
                                            child: CreditItem(
                                              imageUrl: tvDetailProvider
                                                  .tvCredit[index].profilePath,
                                              name: tvDetailProvider
                                                  .tvCredit[index].name,
                                              character: tvDetailProvider
                                                  .tvCredit[index].character,
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
// TODO : TV SEASON ITEM

class TvSeasonItem extends StatelessWidget {
  final String name;
  final String? posterPath;
  final int episode;
  final DateTime? airDate;

  const TvSeasonItem({
    Key? key,
    required this.name,
    required this.posterPath,
    required this.episode,
    required this.airDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 120,
      decoration: BoxDecoration(
        color: lightBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 120,
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
            child: posterPath != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        name,
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                        maxFontSize: 18,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AutoSizeText(
                        '${airDate != null ? DateFormat('yyyy').format(airDate!) : 'No Data'} | $episode Episode',
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                        maxFontSize: 14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  AutoSizeText(
                    'This season airs on ${airDate != null ? DateFormat('MMM dd, yyyy').format(airDate!) : 'No Data'}',
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                    maxFontSize: 14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
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
