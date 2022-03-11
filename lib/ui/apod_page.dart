import 'package:apod/api/mock_service.dart';
import 'package:apod/cards/apod_card.dart';
import 'package:flutter/material.dart';

import '../api_model/apod.dart';

class ApodsPage extends StatefulWidget {
  const ApodsPage({Key? key}) : super(key: key);

  @override
  State<ApodsPage> createState() => _ApodsPageState();
}

class _ApodsPageState extends State<ApodsPage> {
  final mockApodService = MockApodService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockApodService.getApods(),
        builder: (BuildContext context, AsyncSnapshot<List<Apod>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                ),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: (index != 0) ? 12.0 : 0),
                    child: ApodCard(apod: snapshot.data![index]),
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
