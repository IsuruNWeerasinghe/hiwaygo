import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';

enum ReviewRating {
  terrible, // Index 0 (1 Star)
  poor,     // Index 1 (2 Stars)
  okay,     // Index 2 (3 Stars)
  good,     // Index 3 (4 Stars)
  excellent,// Index 4 (5 Stars)
}

class AddReviewDialog extends StatefulWidget {
  final String title;
  final Function(
      ReviewRating overall,
      ReviewRating driver,
      ReviewRating conductor,
      ReviewRating bus,
      String? comment,
      ) onSubmit;

  const AddReviewDialog({
    super.key,
    this.title = "Add Your Review",
    required this.onSubmit,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  ReviewRating? _overallSatisfaction;
  ReviewRating? _driverRating;
  ReviewRating? _conductorRating;
  ReviewRating? _busRating;
  final TextEditingController _commentController = TextEditingController();

  // Color map for the star gradient (optional, but nice UX)
  final Map<ReviewRating, Color> _starColorMap = const {
    ReviewRating.terrible: Color(0xFFE53935), // Red (1 Star)
    ReviewRating.poor: Color(0xFFFF9800),    // Orange (2 Stars)
    ReviewRating.okay: Color(0xFFFFEB3B),    // Yellow (3 Stars)
    ReviewRating.good: Color(0xFF8BC34A),    // Light Green (4 Stars)
    ReviewRating.excellent: Color(0xFF4CAF50), // Green (5 Stars)
  };

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _overallSatisfaction != null &&
        _driverRating != null &&
        _conductorRating != null &&
        _busRating != null;
  }

  // 💡 MODIFIED: Uses IconButton and Row for 5-star rating
  Widget _buildRatingSection({
    required String title,
    required ReviewRating? currentValue,
    required ValueChanged<ReviewRating?> onChanged,
  }) {
    // Current rating index (e.g., Terrible=0, Excellent=4) or -1 if null
    final int selectedIndex = currentValue?.index ?? -1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.colorBlack,
            ),
          ),
          const SizedBox(height: 8.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(ReviewRating.values.length, (index) {
              // The star position (1 to 5)
              final int starPosition = index + 1;

              // The ReviewRating value corresponding to this star
              final ReviewRating ratingValue = ReviewRating.values[index];

              // Check if this star should be filled
              final bool isFilled = starPosition <= (selectedIndex + 1);

              // Get color from the map based on the star's enum value
              final Color starColor = isFilled
                  ? _starColorMap[ratingValue]!
                  : Colors.grey.shade300; // Unfilled color

              return IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 35), // Control icon spacing
                icon: Icon(
                  Icons.star,
                  color: starColor,
                  size: 32.0,
                ),
                onPressed: () {
                  // If the user taps the currently selected star, deselect (set to null).
                  // Otherwise, select the rating corresponding to this star's index.
                  final newRating = (selectedIndex == index) ? null : ratingValue;
                  onChanged(newRating);
                },
              );
            }),
          ),

          // Optional: Display the selected rating label below the stars
          if (currentValue != null)
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 2.0),
              child: Text(
                currentValue.name.toUpperCase(), // Display enum name as text
                style: GoogleFonts.inter(
                    color: _starColorMap[currentValue]!,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),

              _buildRatingSection(
                title: "Overall satisfaction",
                currentValue: _overallSatisfaction,
                onChanged: (rating) {
                  setState(() => _overallSatisfaction = rating);
                },
              ),
              _buildRatingSection(
                title: "How you feel about the driver?",
                currentValue: _driverRating,
                onChanged: (rating) {
                  setState(() => _driverRating = rating);
                },
              ),
              _buildRatingSection(
                title: "How you feel about the conductor?",
                currentValue: _conductorRating,
                onChanged: (rating) {
                  setState(() => _conductorRating = rating);
                },
              ),
              _buildRatingSection(
                title: "How you feel about the bus?",
                currentValue: _busRating,
                onChanged: (rating) {
                  setState(() => _busRating = rating);
                },
              ),

              const SizedBox(height: 10.0),
              Text(
                "Additional Comments (Optional)",
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _commentController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "Share your thoughts...",
                  hintStyle: GoogleFonts.inter(color: AppColors.colorTealBlue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppColors.colorTealBlue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: AppColors.colorCyanPulse, width: 2.0),
                  ),
                ),
                style: GoogleFonts.inter(color: AppColors.colorBlack),
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(), // Close without submitting
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorTealBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isFormValid()
                          ? () {
                        widget.onSubmit(
                          _overallSatisfaction!,
                          _driverRating!,
                          _conductorRating!,
                          _busRating!,
                          _commentController.text.isEmpty ? null : _commentController.text,
                        );
                        Navigator.of(context).pop(); // Close the dialog after submission
                      }
                          : null, // Disable button if form is not valid
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid() ? AppColors.colorCyanPulse : AppColors.colorCyanPulse.withOpacity(0.5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Submit Review",
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}