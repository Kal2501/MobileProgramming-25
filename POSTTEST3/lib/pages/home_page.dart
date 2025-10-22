import 'package:flutter/material.dart';
import '../models/review_model.dart';
import '../widgets/review_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sortedReviews = List<Review>.from(allReviews.reversed);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sortedReviews.length,
        itemBuilder: (context, index) {
          return ReviewCard(review: sortedReviews[index]);
        },
      ),
    );
  }
}
