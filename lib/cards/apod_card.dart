import 'package:apod/styles/apod_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api_model/apod.dart';

const cardWidth = 350.0;
const cardHeight = 450.0;
const cardPadding = 16.0;
const cardRadius = 10.0;

@immutable
class ApodCard extends StatelessWidget {
  ApodCard({
    Key? key,
    required this.apod,
  }) : super(key: key);
  Apod apod;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        (apod.displayImageUrl != null)
            ? _buildCardBackground(apod)
            : Container(
                constraints: const BoxConstraints.expand(
                    height: cardHeight, width: cardWidth),
                child: const Icon(
                  Icons.play_circle,
                  size: 72,
                  color: Colors.black54,
                ),
              ),
        _buildTopOverlay(apod),
        Positioned(
          bottom: 0,
          child: _buildBottomOverlay(apod),
        ),
      ]),
    );
  }

  Widget _buildCardBackground(Apod apod) {
    return Container(
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(apod.displayImageUrl!),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }

  Widget _buildTopOverlay(Apod apod) {
    return Container(
      height: 60,
      constraints: const BoxConstraints.expand(
        width: cardWidth,
        height: 72,
      ),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cardRadius),
          topRight: Radius.circular(cardRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: cardPadding,
          left: cardPadding,
          right: cardPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              apod.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: ApodTheme.darkTextTheme.headline2,
            ),
            const SizedBox(
              height: 8.0,
            ),
            apod.date != null
                ? Text(
                    DateFormat('yyyy-MM-dd').format(apod.date!),
                    style: ApodTheme.darkTextTheme.bodyText1,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildBottomOverlay(Apod apod) {
    return Container(
      height: 30,
      constraints: const BoxConstraints.expand(
        height: 52,
        width: cardWidth,
      ),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: cardPadding,
          left: cardPadding,
          right: cardPadding,
        ),
        child: Text(
          apod.copyright,
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
          style: ApodTheme.darkTextTheme.bodyText1,
        ),
      ),
    );
  }
}
