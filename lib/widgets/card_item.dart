import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/widgets/shimmer_item.dart';

import '../theme.dart';

class CardItem extends StatelessWidget {
  final int id;
  final String? title;
  final String? posterPath;
  final String voteAverage;
  const CardItem({
    Key? key,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: greyColor,
            ),
            child: posterPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: posterPath!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerItem(),
                    ),
                  )
                : const Center(child: Icon(Icons.image)),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
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
                voteAverage,
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
                maxFontSize: 14,
                minFontSize: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          AutoSizeText(
            title!,
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
            maxFontSize: 14,
            minFontSize: 14,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
