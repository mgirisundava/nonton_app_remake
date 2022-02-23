import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class GenreItem extends StatelessWidget {
  final int index;
  final String name;
  const GenreItem({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: index == 0 ? 10 : 0,
        right: 10,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: blackColor.withOpacity(0.8),
          border: Border.all(
            color: whiteColor.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FittedBox(
          child: Center(
            child: AutoSizeText(
              name,
              style: greyTextStyle.copyWith(fontSize: 14),
              maxFontSize: 14,
              minFontSize: 14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}