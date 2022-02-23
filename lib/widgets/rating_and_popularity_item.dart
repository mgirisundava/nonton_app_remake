import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class RatingAndPopularityItem extends StatelessWidget {
  final num voteAverage, voteCount, popularity;
  const RatingAndPopularityItem({
    Key? key,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup1 = AutoSizeGroup();

    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      height: 80,
      color: lightBlackColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      voteAverage.toString(),
                      style: orangeTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                      maxFontSize: 18,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: voteAverage >= 2 ? orangeColor : greyColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: voteAverage >= 4 ? orangeColor : greyColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: voteAverage >= 6 ? orangeColor : greyColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: voteAverage >= 8 ? orangeColor : greyColor,
                        ),
                        Icon(
                          Icons.star,
                          size: 18,
                          color: voteAverage >= 10 ? orangeColor : greyColor,
                        ),
                      ],
                    ),
                  ],
                ),
                AutoSizeText(
                  '$voteCount Vote'.toString(),
                  style: greyTextStyle.copyWith(fontSize: 16),
                  maxFontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  group: autoSizeGroup1,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  '$popularity',
                  style: orangeTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  maxFontSize: 18,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(
                  'Popularity',
                  style: greyTextStyle.copyWith(fontSize: 16),
                  maxFontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  group: autoSizeGroup1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
