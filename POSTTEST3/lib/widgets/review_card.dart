import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, color: Colors.grey, size: 32),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.email,
                    style: GoogleFonts.plusJakartaSans(fontSize: 12),
                  ),
                  Text(
                    "${review.date.day}/${review.date.month}/${review.date.year}",
                    style: GoogleFonts.plusJakartaSans(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: review.images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, i) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(review.images[i])),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            review.keyboardName,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            review.description,
            style: GoogleFonts.plusJakartaSans(fontSize: 12),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              _Tag(icon: Icons.star_rounded, text: "Rate ${review.rating}/5"),
              const SizedBox(width: 8),
              _Tag(icon: Icons.keyboard, text: review.switchType),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Tag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
