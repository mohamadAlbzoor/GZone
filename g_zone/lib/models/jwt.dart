class JWT {
  final String jwt;

  JWT({
    required this.jwt,
  });

  static JWT fromJson(Map<String, dynamic> json) => JWT(
        jwt: json['token'],
      );
}
