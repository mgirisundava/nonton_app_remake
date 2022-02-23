import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class NoReviewItem extends StatelessWidget {
  const NoReviewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: whiteColor.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: AutoSizeText(
          'No Review',
          style: greyTextStyle.copyWith(
            fontSize: 14,
          ),
          maxFontSize: 14,
          minFontSize: 14,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
