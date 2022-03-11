class Apod {
  final DateTime? date;
  final MediaType mediaType;
  final String copyright;
  final String title;
  final String explanation;
  final String? displayImageUrl;
  final String? hdUrl;
  final String? videoUrl;

  const Apod({
    this.date,
    this.mediaType = MediaType.image,
    this.copyright = 'Public domain',
    this.title = '',
    this.explanation = '',
    this.displayImageUrl = '',
    this.hdUrl,
    this.videoUrl,
  });

  factory Apod.fromJson(Map<String, dynamic> json) {
    final String dateString = json['date'];

    final dateParts = dateString.split('-');
    DateTime? date;
    if (dateParts.length == 3) {
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);
      date = DateTime(year, month, day);
    }

    final mediaType =
        json['media_type'] == 'image' ? MediaType.image : MediaType.video;

    String? displayImageUrl;
    if (mediaType == MediaType.image) {
      displayImageUrl = json['url'];
    } else {
      final fileName = json['thumbnail_url'].toString().split('/').last;
      final fileType = fileName.split('.').last.toLowerCase();
      if (fileType.contains('jpeg') ||
          fileType.contains('jpg') ||
          fileType.contains('png')) {
        displayImageUrl = json['thumbnail_url'];
      }
    }

    final videoUrl = mediaType == MediaType.video ? json['url'] : null;
    final String copyright = json['copyright'] ?? 'Public domain';

    return Apod(
      date: date,
      mediaType: mediaType,
      copyright: copyright,
      title: json['title'] ?? '',
      explanation: json['explanation'],
      displayImageUrl: displayImageUrl,
      hdUrl: json['hdUrl'],
      videoUrl: videoUrl,
    );
  }
}

enum MediaType {
  image,
  video,
}



// class StringIdConverter implements JsonConverter<String, int>{
//    const StringIdConverter();

//   @override
//   String fromJson(int json) => 

//   @override
//   int toJson(String object) {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }

// }

