import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api_model/apod.dart';
import '../styles/apod_theme.dart';

const cardRadius = 10.0;

@immutable
class ApodThumbnail extends StatelessWidget {
  ApodThumbnail({
    Key? key,
    required this.apod,
  }) : super(key: key);
  Apod apod;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(apod.displayImageUrl!),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(apod.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: ApodTheme.lightTextTheme.bodyText1),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              apod.copyright,
              style: ApodTheme.lightTextTheme.bodyText1,
            )
          ],
        ));
  }
}
