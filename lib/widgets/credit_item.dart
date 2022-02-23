import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/widgets/shimmer_item.dart';

import '../theme.dart';

class CreditItem extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String character;
  const CreditItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyColor,
      ),
      width: 100,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: double.infinity,
              height: 140,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerItem(),
                    )
                  : const Center(
                      child: Icon(Icons.person),
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: lightBlackColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    name,
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                    maxFontSize: 14,
                    minFontSize: 14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AutoSizeText(
                    character,
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
          ),
        ],
      ),
    );
  }
}
