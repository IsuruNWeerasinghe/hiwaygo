import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';

enum ReviewRating {
  terrible,
  poor,
  okay,
  good,
  excellent,
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

  final Map<ReviewRating, String> _ratingLabels = {
    ReviewRating.terrible: "Terrible",
    ReviewRating.poor: "Poor",
    ReviewRating.okay: "Okay",
    ReviewRating.good: "Good",
    ReviewRating.excellent: "Excellent",
  };

  final Map<ReviewRating, Color> _ratingColors = {
    ReviewRating.terrible: Colors.red.shade700,
    ReviewRating.poor: Colors.orange.shade700,
    ReviewRating.okay: Colors.yellow.shade800,
    ReviewRating.good: Colors.lightGreen.shade700,
    ReviewRating.excellent: Colors.green.shade700,
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

  Widget _buildRatingSection({
    required String title,
    required ReviewRating? currentValue,
    required ValueChanged<ReviewRating?> onChanged,
  }) {
    return Column(
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
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: ReviewRating.values.map((rating) {
            bool isSelected = currentValue == rating;
            return ChoiceChip(
              label: Text(_ratingLabels[rating]!),
              selected: isSelected,
              selectedColor: _ratingColors[rating],
              disabledColor: AppColors.colorTealBlue.withOpacity(0.2),
              labelStyle: GoogleFonts.inter(
                color: isSelected ? Colors.white : AppColors.colorBlack,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (selected) {
                onChanged(selected ? rating : null);
              },
              side: BorderSide(
                color: isSelected ? Colors.transparent : AppColors.colorTealBlue,
                width: 1.0,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 15.0),
      ],
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
        child: SingleChildScrollView( // Added SingleChildScrollView
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
                  setState(() {
                    _overallSatisfaction = rating;
                  });
                },
              ),
              _buildRatingSection(
                title: "How you feel about the driver?",
                currentValue: _driverRating,
                onChanged: (rating) {
                  setState(() {
                    _driverRating = rating;
                  });
                },
              ),
              _buildRatingSection(
                title: "How you feel about the conductor?",
                currentValue: _conductorRating,
                onChanged: (rating) {
                  setState(() {
                    _conductorRating = rating;
                  });
                },
              ),
              _buildRatingSection(
                title: "How you feel about the bus?",
                currentValue: _busRating,
                onChanged: (rating) {
                  setState(() {
                    _busRating = rating;
                  });
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
                maxLines: 3,
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
                  const SizedBox(width: 15.0),
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