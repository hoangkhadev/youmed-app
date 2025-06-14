import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class FilterScreen extends StatefulWidget {
  final String selectedPlaceType;
  final String selectedLocation;
  final Function(String placeType, String location) onApply;

  const FilterScreen({
    super.key,
    required this.selectedPlaceType,
    required this.selectedLocation,
    required this.onApply,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String selectedPlaceType;
  late String selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedPlaceType = widget.selectedPlaceType;
    selectedLocation = widget.selectedLocation;
  }

  void _resetAllFilters() {
    setState(() {
      selectedPlaceType = "Tất cả";
      selectedLocation = "Tất cả";
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeOptions = [
      "Bác sĩ",
      "Bệnh viện",
      "Phòng khám",
      "Trung tâm tiêm chủng",
      "Tất cả",
    ];
    final locationOptions = ["Gần nhất", "Tất cả"];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: GlobalColors.whiteColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Bộ lọc',
              style: TextStyle(
                color: GlobalColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Địa điểm",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...locationOptions.map(
              (opt) => RadioListTile(
                title: Text(opt),
                value: opt,
                groupValue: selectedLocation,
                onChanged: (value) => setState(() => selectedLocation = value!),
              ),
            ),
            const Divider(height: 32),
            const Text(
              "Nơi khám",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...placeOptions.map(
              (opt) => RadioListTile(
                title: Text(opt),
                value: opt,
                groupValue: selectedPlaceType,
                onChanged:
                    (value) => setState(() => selectedPlaceType = value!),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _resetAllFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Xóa bộ lọc',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(selectedPlaceType, selectedLocation);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Áp dụng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
