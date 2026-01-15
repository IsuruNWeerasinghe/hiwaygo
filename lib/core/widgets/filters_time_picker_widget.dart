// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hiwaygo/core/constants/app_colors.dart';
//
// class FilterTimePickerWidget extends StatefulWidget {
//   final Size size;
//   final String label;
//   final TimeOfDay? initialTime;
//   final ValueChanged<TimeOfDay> onTimeSelected;
//
//   const FilterTimePickerWidget({
//     super.key,
//     required this.size,
//     required this.onTimeSelected,
//     required this.label,
//     this.initialTime,
//   });
//
//   @override
//   State<FilterTimePickerWidget> createState() => _FilterTimePickerWidgetState();
// }
//
// class _FilterTimePickerWidgetState extends State<FilterTimePickerWidget> {
//   TimeOfDay? _selectedTime;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize with the time passed from the parent, if any
//     _selectedTime = widget.initialTime;
//   }
//
//   // Helper method to format TimeOfDay into a display string
//   String _formatTime(TimeOfDay time) {
//     // Uses the context's locale settings for 12/24 hour format
//     final MaterialLocalizations localizations = MaterialLocalizations.of(context);
//     return localizations.formatTimeOfDay(time);
//   }
//
//   Future<void> _pickTime() async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//       initialEntryMode: TimePickerEntryMode.inputOnly,
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
//             // Override button style if needed
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(foregroundColor: AppColors.colorTealBlue),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedTime != null) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//       // Call the callback function to send the time back to the parent filter logic
//       widget.onTimeSelected(pickedTime);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Display the selected time or the label text
//     final String displayText = _selectedTime == null
//         ? widget.label
//         : _formatTime(_selectedTime!);
//
//     return GestureDetector(
//       onTap: _pickTime,
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
//                 color: _selectedTime == null ? Colors.grey.shade600 : AppColors.colorTealBlue,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Icon(
//               Icons.access_time,
//               color: AppColors.colorTealBlue,
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }