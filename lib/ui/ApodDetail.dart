import 'package:apod/api/mock_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api_model/apod.dart';
import '../provider_model/journal_manager.dart';

class ApodDetail extends StatefulWidget {
  const ApodDetail({
    Key? key,
    required this.apodId,
  }) : super(key: key);
  final int apodId;

  static Page page({
    LocalKey? key,
    int? apodId,
  }) {
    return MaterialPage(
      key: key,
      child: ApodDetail(
        apodId: apodId!,
      ),
    );
  }

  @override
  State<ApodDetail> createState() => _ApodDetailState();
}

class _ApodDetailState extends State<ApodDetail> {
  Apod? apod;
  final TransformationController _controller = TransformationController();
  double _sliderScalar = 1.0;

  @override
  void initState() {
    super.initState();

    final service = MockApodService();
    service.getSingleApod(widget.apodId).then((value) => setState(() {
          apod = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    if (apod == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(apod!.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.4,
                width: double.infinity,
                child: _getImage(),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (apod!.mediaType == MediaType.image)
                Slider(
                  min: 1.0,
                  max: 4.0,
                  divisions: 20,
                  label: _sliderScalar.toStringAsPrecision(2),
                  value: _sliderScalar.toDouble(),
                  onChanged: (newValule) {
                    _sliderScalar = newValule;
                    _controller.value =
                        Matrix4.identity().scaled(_sliderScalar);
                  },
                  activeColor: Colors.purple[200],
                  inactiveColor: Colors.purple[800],
                ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd').format(apod!.date!),
                          style: theme.textTheme.bodyText1,
                        ),
                        if (apod!.mediaType == MediaType.image)
                          Chip(
                            backgroundColor: Colors.purple,
                            label: Text(
                              'Zoom: ${_sliderScalar.toStringAsPrecision(2)}',
                              style: theme.textTheme.bodyText1!
                                  .copyWith(color: Colors.white),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      apod!.title,
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Copyright: ${apod!.copyright}',
                      softWrap: false,
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      apod!.explanation,
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 72,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImage() {
    if (apod!.displayImageUrl != null) {
      if (apod!.mediaType == MediaType.image) {
        return InteractiveViewer(
          child: Image.asset(
            apod!.displayImageUrl!,
            fit: BoxFit.fitWidth,
          ),
        );
      } else {
        return Stack(
          children: [
            Image(
              image: AssetImage(apod!.displayImageUrl!),
              fit: BoxFit.fitWidth,
            ),
            const Center(
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
              ),
            ),
          ],
        );
      }
    } else {
      return Container(
        color: Colors.black45,
        child: const Icon(
          Icons.play_circle_outlined,
          size: 72,
          color: Colors.white,
        ),
      );
    }
  }
}
