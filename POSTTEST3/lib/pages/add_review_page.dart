import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../models/review_model.dart';
import 'profile_page.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _switchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final List<dynamic> _images = [];
  double _rating = 3;

  Future<void> _pickImage() async {
    if (_images.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kamu hanya boleh upload 3 foto.")),
      );
      return;
    }

    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() => _images.add(bytes));
      } else {
        setState(() => _images.add(File(picked.path)));
      }
    }
  }

  Widget _buildImagePreview(dynamic image) {
    if (kIsWeb) {
      return Image.memory(image, width: 100, height: 100, fit: BoxFit.cover);
    } else {
      return Image.file(image, width: 100, height: 100, fit: BoxFit.cover);
    }
  }

  void _saveReview() {
    if (_nameController.text.isEmpty ||
        _descController.text.isEmpty ||
        _switchController.text.isEmpty ||
        _images.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi semua kolom dan upload 3 foto!")),
      );
      return;
    }

    if (_descController.text.split(" ").length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deskripsi maksimal 100 kata!")),
      );
      return;
    }

    if (currentUserEmail == null || currentUserEmail!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User belum login.")));
      return;
    }

    final imagePaths = _images.map((img) {
      if (img is File) return img.path;
      return "";
    }).toList();

    allReviews.add(
      Review(
        email: currentUserEmail!,
        keyboardName: _nameController.text.trim(),
        images: imagePaths,
        description: _descController.text.trim(),
        rating: _rating.round(),
        switchType: _switchController.text.trim(),
        date: DateTime.now(),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Review", style: GoogleFonts.plusJakartaSans()),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama Keyboard",
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              style: GoogleFonts.plusJakartaSans(),
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Contoh: Keychron K6",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Upload 3 Foto",
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ..._images.map(
                  (img) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _buildImagePreview(img),
                  ),
                ),
                if (_images.length < 3)
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black54,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              "Deskripsi (max 100 kata)",
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              style: GoogleFonts.plusJakartaSans(),
              controller: _descController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Review dari keyboard",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Rating (${_rating.toStringAsFixed(1)})",
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: _rating.toString(),
              activeColor: Colors.lightGreen,
              onChanged: (val) => setState(() => _rating = val),
            ),
            const SizedBox(height: 20),

            Text(
              "Switch yang digunakan",
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _switchController,
              style: GoogleFonts.plusJakartaSans(),
              decoration: InputDecoration(
                hintText: "Contoh: Gateron Red / Cherry MX Blue",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Simpan Review",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
