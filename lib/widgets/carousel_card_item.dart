import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/pages/movie_detail_page.dart';
import 'package:nonton_app/pages/tv_detail_page.dart';
import 'package:nonton_app/theme.dart';
import 'package:nonton_app/widgets/shimmer_item.dart';

class CarouselCardItem extends StatelessWidget {
  final int id;
  final String? imageUrl;
  final String voteAverage;
  final bool isMovie;
  const CarouselCardItem({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.voteAverage,
    required this.isMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            isMovie == true
                ? MovieDetailPage.routeName
                : TvDetailPage.routeName,
            arguments: id);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              imageUrl != null
                  ? SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ShimmerItem(),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image),
                    ),
              Container(
                width: MediaQuery.of(context).size.width * 1 / 5,
                height: MediaQuery.of(context).size.height * 1 / 18,
                decoration: BoxDecoration(
                  color: lightBlackColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
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
                          voteAverage,
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
        ),
      ),
    );
  }
}
