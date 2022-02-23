import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nonton_app/providers/people_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';
import '../widgets/shimmer_item.dart';

class PersonDetailPage extends StatelessWidget {
  const PersonDetailPage({Key? key}) : super(key: key);

  static const routeName = 'person-detail';

  @override
  Widget build(BuildContext context) {
    final personDetailProvider =
        Provider.of<PersonDetailProvider>(context, listen: false);
    final personId = ModalRoute.of(context)!.settings.arguments as int;

    void _launchUrl(String url) async => await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';

    return Scaffold(
      backgroundColor: blackColor,
      body: FutureBuilder(
        future: personDetailProvider.getPersonDetail(personId),
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
                    background: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: greyColor,
                      child: personDetailProvider
                                  .personDetail['profile_path'] !=
                              null
                          ? CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original' +
                                  personDetailProvider
                                      .personDetail['profile_path'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const ShimmerItem(),
                            )
                          : const Center(
                              child: Icon(Icons.image),
                            ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            AutoSizeText(
                              personDetailProvider.personDetail['name'] ??
                                  personDetailProvider
                                      .personDetail['original_name'],
                              style: whiteTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                              maxFontSize: 18,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
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
                            ReadMoreText(
                              personDetailProvider.personDetail['biography'] ==
                                      ''
                                  ? 'No Description'
                                  : personDetailProvider
                                      .personDetail['biography'],
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                height: 1.5,
                              ),
                              trimMode: TrimMode.Line,
                              trimLines: 5,
                              colorClickableText: orangeColor,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: AutoSizeText(
                                'Information',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: semiBold,
                                ),
                                maxFontSize: 18,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Column(
                              children: [
                                DetailText(
                                  title: 'Date of Birth : ',
                                  value: personDetailProvider
                                          .personDetail['birthday'] ??
                                      '-',
                                ),
                              ],
                            ),
                            DetailText(
                              title: 'Date of Death : ',
                              value: personDetailProvider
                                      .personDetail['deathday'] ??
                                  '-',
                            ),
                            DetailText(
                              title: 'Place of Birth : ',
                              value: personDetailProvider
                                      .personDetail['place_of_birth'] ??
                                  'No Data',
                            ),
                            DetailText(
                              title: 'Gender : ',
                              value:
                                  personDetailProvider.personDetail['gender'] ==
                                          2
                                      ? 'Male'
                                      : personDetailProvider
                                                  .personDetail['gender'] ==
                                              1
                                          ? 'Female'
                                          : 'No Data',
                            ),
                            DetailText(
                              title: 'Department : ',
                              value: personDetailProvider
                                      .personDetail['known_for_department'] ??
                                  'No Data',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
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
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            title!,
            style: greyTextStyle.copyWith(
              fontSize: 14,
            ),
            maxFontSize: 14,
            minFontSize: 14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: AutoSizeText(
              value!,
              style: whiteTextStyle.copyWith(
                fontSize: 14,
              ),
              maxFontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
