import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/pages/person_detail_page.dart';
import 'package:nonton_app/providers/see_all_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:nonton_app/widgets/shimmer_item.dart';
import 'package:provider/provider.dart';

class SeeAllCreditsPage extends StatelessWidget {
  const SeeAllCreditsPage({Key? key}) : super(key: key);
  static const routeName = 'see-all-credits';

  @override
  Widget build(BuildContext context) {
    final seeAllProvider = Provider.of<SeeAllProvider>(context, listen: false);
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    // arguments[0] = id, arguments[1] = mediaType

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text(
          arguments[1].toUpperCase(),
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        backgroundColor: blackColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: seeAllProvider.getSeeAllCredits(arguments[0], arguments[1]),
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
                      PersonDetailPage.routeName,
                      arguments: seeAllProvider.seeAllCredits[index].id,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: index == 0 || index == 1 || index == 2 ? 10 : 0,
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
                                        .seeAllCredits[index].profilePath !=
                                    null
                                ? CachedNetworkImage(
                                    imageUrl: seeAllProvider
                                        .seeAllCredits[index].profilePath!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const ShimmerItem(),
                                  )
                                : Center(
                                    child: AutoSizeText(
                                      seeAllProvider.seeAllCredits[index].name,
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
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 1 / 7,
                            decoration: BoxDecoration(
                              color: lightBlackColor.withOpacity(0.8),
                            ),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    seeAllProvider.seeAllCredits[index].name,
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                    maxFontSize: 16,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  AutoSizeText(
                                    seeAllProvider
                                        .seeAllCredits[index].character,
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                    maxFontSize: 14,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: seeAllProvider.seeAllCreditsLength,
              ),
            );
          }
        },
      ),
    );
  }
}
