class Review {
  final String email;
  final String keyboardName;
  final List<String> images;
  final String description;
  final int rating;
  final String switchType;
  final DateTime date;

  Review({
    required this.email,
    required this.keyboardName,
    required this.images,
    required this.description,
    required this.rating,
    required this.switchType,
    required this.date,
  });
}

List<Review> allReviews = [];
