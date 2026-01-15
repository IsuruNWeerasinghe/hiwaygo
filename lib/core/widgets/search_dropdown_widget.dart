import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwaygo/core/constants/app_colors.dart';


class SearchDropdownWidget extends StatefulWidget {
  final Size size;
  final String hintText;
  final IconData textIcon;
  final List<String> itemsList;
  final TextEditingController onChangedController;

  const SearchDropdownWidget({
    super.key,
    required this.hintText,
    required this.textIcon,
    required this.itemsList,
    required this.onChangedController,
    required this.size,
  });

  @override
  State<SearchDropdownWidget> createState() => _SearchDropdownWidgetState();
}

class _SearchDropdownWidgetState extends State<SearchDropdownWidget> {
  String? selectedItem;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // This helper builds your custom suffix icon
  Widget _buildSuffixIcon() {
    bool isSelected = selectedItem != null;
    return Container(
      margin: const EdgeInsets.only(right: 12),
      alignment: Alignment.center,
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: isSelected ? AppColors.colorCyanPulse : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.check, color: Colors.white, size: 13)
          : const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedItem != null;

    return Container(
      // This container provides the shadow
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: selectedItem,
          // --- Custom Button ---
          // This builds the collapsed state to match your UI
          customButton: Container(
            height: widget.size.height / 13,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.transparent
                  : const Color.fromRGBO(248, 247, 251, 1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: isSelected
                    ? AppColors.colorCyanPulse
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Icon(
                    widget.textIcon,
                    color: isSelected
                        ? AppColors.colorCyanPulse
                        : const Color(0xFF151624).withOpacity(0.5),
                    size: 16,
                  ),
                ),
                Expanded(
                  child: Text(
                    selectedItem ?? widget.hintText,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: isSelected
                          ? const Color(0xFF151624)
                          : const Color(0xFF151624).withOpacity(0.5),
                    ),
                  ),
                ),
                _buildSuffixIcon(),
              ],
            ),
          ),

          // --- Dropdown Menu Items ---
          items: widget.itemsList.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF151624),
                ),
              ),
            );
          }).toList(),

          // --- OnChange ---
          onChanged: (value) {
            setState(() {
              selectedItem = value;
              widget.onChangedController.text = value ?? "";
            });
          },

          // --- Dropdown Menu Styling ---
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // --- Search Box ---
          dropdownSearchData: DropdownSearchData(
            searchInnerWidgetHeight: widget.size.height/5,
            searchController: _searchController,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search here...",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: const Color(0xFF151624).withOpacity(0.5),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase());
            },
          ),
          // Hide search box when no items are found
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              _searchController.clear();
            }
          },
        ),
      ),
    );
  }
}