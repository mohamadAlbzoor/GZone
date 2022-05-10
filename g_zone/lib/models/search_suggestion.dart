class SearchSuggestion {
  final String name;


  SearchSuggestion({required this.name});

  static SearchSuggestion fromJson(Map<String, dynamic> json) => SearchSuggestion(
      name: json['name']
  );
}
