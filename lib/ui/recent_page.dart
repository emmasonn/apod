import 'package:apod/api/mock_service.dart';
import 'package:apod/cards/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../api_model/apod.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({Key? key}) : super(key: key);

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  @override
  Widget build(BuildContext context) {
    final mockService = MockApodService();
    return FutureBuilder(
        future: mockService.getApods(),
        builder: (BuildContext context, AsyncSnapshot<List<Apod>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final apods = snapshot.data ?? [];
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => context.go('/apod/${apods[index].id}'),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 12.0 : 0,
                        bottom: 12.0,
                      ),
                      child: FavoriteCard(
                        apod: apods[index],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
