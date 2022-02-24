import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/widgets/shimmer_item.dart';

import '../theme.dart';

class PosterGridItem extends StatelessWidget {
  final int index;
  final String? posterPath;
  final String title;
  final num voteAverage;
  const PosterGridItem({
    Key? key,
    required this.index,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: posterPath != null
                  ? CachedNetworkImage(
                      imageUrl: posterPath!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerItem(),
                    )
                  : Center(
                      child: AutoSizeText(
                        title,
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
                      voteAverage.toString(),
                      style: whiteTextStyle.copyWith(fontSize: 16),
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
    );
  }
}
