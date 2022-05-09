class GameInformation {
  final String name;
  final String releaseDate;
  final String categories;
  final String genres;
  final int positiveRatings;
  final int negativeRatings;
  final double price;
  final String owners;

  GameInformation({
    required this.owners,
    required this.price,
    required this.negativeRatings,
    required this.positiveRatings,
    required this.genres,
    required this.categories,
    required this.releaseDate,
    required this.name
  });

  static GameInformation fromJson(Map<String, dynamic> json) => GameInformation(
      owners: json['owners'],
      price: json['price'],
      negativeRatings: json['negative_ratings'],
      positiveRatings: json['positive_ratings'],
      genres: json['genres'],
      categories: json['categories'],
      releaseDate: json['release_date'],
      name: json['name']
  );
}
