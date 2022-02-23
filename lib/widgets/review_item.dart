import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class ReviewItem extends StatelessWidget {
  final String author, content, url;
  const ReviewItem({
    Key? key,
    required this.author,
    required this.content,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchUrl(String url) async => await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: whiteColor.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          AutoSizeText(
            author,
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
          const Spacer(),
          AutoSizeText(
            content,
            style: greyTextStyle.copyWith(
              fontSize: 14,
              height: 1.5,
            ),
            maxFontSize: 14,
            minFontSize: 14,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _launchUrl(url);
            },
            child: AutoSizeText(
              'See Detail',
              style: greyTextStyle.copyWith(
                color: Colors.blue,
                fontSize: 14,
              ),
              minFontSize: 14,
              maxFontSize: 14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
