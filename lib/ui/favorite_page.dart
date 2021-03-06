import 'package:apod/api/mock_service.dart';
import 'package:apod/cards/apod_thumbnail.dart';
import 'package:flutter/material.dart';

import '../api_model/apod.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final apodService = MockApodService();
    return FutureBuilder(
        future: apodService.getFavoriteApods(),
        builder: (context, AsyncSnapshot<List<Apod>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Apod> apods = snapshot.data ?? [];
            return GestureDetector(
              onTap: () {},
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ApodThumbnail(apod: apods[index]);
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
