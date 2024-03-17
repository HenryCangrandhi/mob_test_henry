import 'package:flutter/material.dart';

class FilterBottomSheet {
  static Future<String?> showFilterBottomSheet({
    required BuildContext context,
    required Function(String) onSelectFilter,
    required String selectedFilter,
  }) async {
    TextEditingController cityController = TextEditingController();
    /// Display the modal bottom sheet with a rounded top edge.
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header of the bottom sheet, displaying the title 'Filter'.
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 18
                    )
                  ),
                ],
              ),
              const SizedBox(height: 24),

              GestureDetector(
                onTap: () {
                  selectedFilter = 'Default';
                  onSelectFilter(selectedFilter);
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Default',
                      style: TextStyle(
                        fontSize: 16
                      )
                    ),

                    /// Radio button for selecting 'Default' (Initial Choice).
                    Radio(
                      value: 'Default',
                      groupValue: selectedFilter,
                      onChanged: (value) {
                        selectedFilter = value.toString();
                        onSelectFilter(selectedFilter);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// Option for filtering by City.
              GestureDetector(
                onTap: () {
                  selectedFilter = 'City';
                  onSelectFilter(selectedFilter);
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'City',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),

                    /// Radio button for selecting by City.
                    Radio(
                      value: 'City',
                      groupValue: selectedFilter,
                      onChanged: (value) {
                        selectedFilter = value.toString();
                        onSelectFilter(selectedFilter);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    /// Return the selected filter value after the bottom sheet is closed.
    return selectedFilter;
  }
}
