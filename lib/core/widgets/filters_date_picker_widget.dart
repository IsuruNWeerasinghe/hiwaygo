// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hiwaygo/core/constants/app_colors.dart';
//
// class FilterDatePickerWidget extends StatefulWidget {
//   final Size size;
//   final String label;
//   final DateTime? initialDate;
//   final ValueChanged<DateTime> onDateSelected;
//
//   const FilterDatePickerWidget({
//     super.key,
//     required this.size,
//     required this.onDateSelected,
//     required this.label,
//     this.initialDate,
//   });
//
//   @override
//   State<FilterDatePickerWidget> createState() => _FilterDatePickerWidgetState();
// }
//
// class _FilterDatePickerWidgetState extends State<FilterDatePickerWidget> {
//   DateTime? _selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize with the date passed from the parent, if any
//     _selectedDate = widget.initialDate;
//   }
//
//   // Helper method to format the date into a display string (DD/MM/YYYY)
//   String _formatDate(DateTime date) {
//     return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
//   }
//
//   Future<void> _pickDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2020), // Start date for picker range
//       lastDate: DateTime(2030),  // End date for picker range
//       builder: (context, child) {
//         // Optional: Custom theme for the dialog
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.colorTealBlue,
//               onPrimary: Colors.white,
//               surface: AppColors.colorBackground,
//               onSurface: AppColors.colorTealBlue,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(foregroundColor: AppColors.colorTealBlue),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//       // Call the callback function to send the date back to the parent filter logic
//       widget.onDateSelected(pickedDate);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Display the selected date or the label text
//     final String displayText = _selectedDate == null
//         ? widget.label
//         : _formatDate(_selectedDate!);
//
//     return GestureDetector(
//       onTap: _pickDate,
//       child: Container(
//         height: 48,
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           border: Border.all(
//             color: AppColors.colorTealBlue,
//             width: 1.5,
//           ),
//           color: AppColors.colorBackground,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               displayText,
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 color: _selectedDate == null ? Colors.grey.shade600 : AppColors.colorTealBlue,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Icon(
//               Icons.calendar_today,
//               color: AppColors.colorTealBlue,
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }