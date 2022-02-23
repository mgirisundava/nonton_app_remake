import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SeeAllText extends StatelessWidget {
  const SeeAllText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          'See All',
          style: greyTextStyle.copyWith(
            fontSize: 14,
          ),
          maxFontSize: 14,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Icon(
          Icons.chevron_right,
          color: greyColor,
        ),
      ],
    );
  }
}
