import 'package:flutter/material.dart';
import 'package:nonton_app/pages/tv_detail_page.dart';
import 'package:nonton_app/providers/tv_detail_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:provider/provider.dart';

class SeeAllSeasonsPage extends StatelessWidget {
  const SeeAllSeasonsPage({Key? key}) : super(key: key);
  static const routeName = 'see-all-seasons';

  @override
  Widget build(BuildContext context) {
    final tvDetailProvider =
        Provider.of<TvDetailProvider>(context, listen: false);
    final tvId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text(
          'ALL SEASONS',
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        backgroundColor: blackColor,
        elevation: 0,
      ),
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
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListView.builder(
                itemCount: tvDetailProvider.tvSeasonsLength,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: index == 0 ? 10 : 0,
                      bottom: 10,
                    ),
                    child: TvSeasonItem(
                      name: tvDetailProvider.tvSeasons[index].name,
                      posterPath: tvDetailProvider.tvSeasons[index].posterPath,
                      episode: tvDetailProvider.tvSeasons[index].episdoeCount,
                      airDate: tvDetailProvider.tvSeasons[index].airDate,
                    ),
                  );
                }),
              ),
            );
          }
        },
      ),
    );
  }
}
