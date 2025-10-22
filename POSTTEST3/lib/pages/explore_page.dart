import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/review_model.dart';
import '../widgets/review_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    final filtered = allReviews
        .where(
          (r) => r.keyboardName.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: GoogleFonts.plusJakartaSans(),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => keyword = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        "Tidak ada hasil",
                        style: GoogleFonts.plusJakartaSans(),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(review: filtered[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
