class Categories {
  String value;

  Categories({
    required this.value,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        value: json as String,
      );
}
