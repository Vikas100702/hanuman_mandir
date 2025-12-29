class AboutModel {
  final String? statusCode;
  final String? message;
  final List<AboutDatum> data;

  AboutModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] == null
          ? []
          : List<AboutDatum>.from(
        json["data"]!.map((x) => AboutDatum.fromJson(x)),
      ),
    );
  }
}

class AboutDatum {
  final String? title;
  final String? description;
  final String? imageUrl;

  AboutDatum({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory AboutDatum.fromJson(Map<String, dynamic> json) {
    return AboutDatum(title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
