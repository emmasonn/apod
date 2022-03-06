import 'package:flutter/foundation.dart';

class Apod {
  const Apod({required this.id, required this.url,});
  final String id;
  final String url;

  Factory Apod.fromJson(Map<String,dynamic> json, this.id, this.url) {
      return Apod(id: id, url: url);
  }


}
