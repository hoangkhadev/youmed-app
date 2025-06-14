import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/search/filter_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/custom_bottom_sheet.dart';

class FilterChipsRow extends StatefulWidget {
  const FilterChipsRow({super.key});

  @override
  State<FilterChipsRow> createState() => _FilterChipsRowState();
}

class _FilterChipsRowState extends State<FilterChipsRow> {
  String selectedPlace = "Tất cả";
  String selectedSort = "Tất cả";

  void _openPlaceBottomSheet() {
    showPlaceFilterBottomSheet(context, selectedPlace, (place) {
      setState(() {
        selectedPlace = place;
      });
    });
  }

  void _openFilterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => FilterScreen(
              selectedPlaceType: selectedPlace,
              selectedLocation: selectedSort,
              onApply: (place, location) {
                setState(() {
                  selectedPlace = place;
                  selectedSort = location;
                });
              },
            ),
      ),
    );
  }

  void _openSortBottomSheet() {
    String tempSelected = selectedSort;
    CustomBottomSheet.show(
      context: context,
      height: 420,
      child: StatefulBuilder(
        builder: (context, setStateModal) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 22,
                      color: GlobalColors.textColor,
                    ),
                  ),
                  const Opacity(
                    opacity: 0,
                    child: Icon(Icons.exit_to_app, size: 24),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Chọn cách sắp xếp các kết quả theo vị trí địa lý phù hợp với bạn nhất.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text(
                            "Gần nhất",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text(
                            "Sắp xếp các vị trí gần với bạn nhất.",
                          ),
                          trailing: Radio<String>(
                            value: "Gần nhất",
                            groupValue: tempSelected,
                            onChanged:
                                (val) =>
                                    setStateModal(() => tempSelected = val!),
                          ),
                          onTap:
                              () => setStateModal(
                                () => tempSelected = "Gần nhất",
                              ),
                        ),
                        ListTile(
                          title: const Text(
                            "Tất cả",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text(
                            "Sắp xếp tự động theo độ phù hợp.",
                          ),
                          trailing: Radio<String>(
                            value: "Tất cả",
                            groupValue: tempSelected,
                            onChanged:
                                (val) =>
                                    setStateModal(() => tempSelected = val!),
                          ),
                          onTap:
                              () =>
                                  setStateModal(() => tempSelected = "Tất cả"),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Để sắp xếp các kết quả gần bạn nhất, vui lòng cho phép ứng dụng truy cập vị trí.",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => selectedSort = tempSelected);
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
                                'Tiếp tục',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showPlaceFilterBottomSheet(
    BuildContext context,
    String selectedPlace,
    Function(String) onApply,
  ) {
    String tempSelected = selectedPlace;
    CustomBottomSheet.show(
      context: context,
      height: 440,
      child: StatefulBuilder(
        builder: (context, setState) {
          final options = [
            "Bác sĩ",
            "Bệnh viện",
            "Phòng khám",
            "Trung tâm tiêm chủng",
            "Tất cả",
          ];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 22,
                      color: GlobalColors.textColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Lọc theo nơi khám',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: GlobalColors.textColor,
                      ),
                    ),
                  ),
                  const Opacity(
                    opacity: 0,
                    child: Icon(Icons.exit_to_app, size: 24),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        ...options.map(
                          (option) => RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: tempSelected,
                            onChanged:
                                (val) => setState(() => tempSelected = val!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onApply(tempSelected);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: GlobalColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Tiếp tục',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          avatar: const Icon(Icons.wifi, size: 18),
          label: Text(selectedSort),
          backgroundColor: GlobalColors.whiteColor,
          side: BorderSide(color: Colors.grey.shade300),
          onSelected: (_) => _openSortBottomSheet(),
        ),
        FilterChip(
          avatar: const Icon(Icons.place_outlined, size: 18),
          label: Text("Nơi khám: $selectedPlace"),
          backgroundColor: GlobalColors.whiteColor,
          side: BorderSide(color: Colors.grey.shade300),
          onSelected: (_) => _openPlaceBottomSheet(),
        ),
        FilterChip(
          avatar: const Icon(Icons.filter_list, size: 18),
          label: const Text("Bộ lọc"),
          backgroundColor: GlobalColors.whiteColor,
          side: BorderSide(color: Colors.grey.shade300),
          onSelected: (_) => _openFilterScreen(),
        ),
      ],
    );
  }
}
