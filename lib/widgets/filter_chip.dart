import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/search/filter_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        String tempSelected = selectedSort;

        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 30,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 22,
                        color: GlobalColors.textColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Sắp xếp kết quả',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: GlobalColors.textColor,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Icon(
                        Icons.exit_to_app,
                        size: 24,
                        color: GlobalColors.textColor,
                      ),
                    ),
                  ],
                ),

                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                () => setStateModal(
                                  () => tempSelected = "Tất cả",
                                ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Để sắp xếp các kết quả gần bạn nhất, vui lòng cho phép ứng dụng truy cập vị trí địa điểm khi có yêu cầu.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
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
                                child: const Text("Áp dụng"),
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
        );
      },
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
          selected: true,
          onSelected: (_) => _openSortBottomSheet(),
        ),
        FilterChip(
          avatar: const Icon(Icons.place_outlined, size: 18),
          label: Text("Nơi khám: $selectedPlace"),
          selected: selectedPlace != "Tất cả",
          onSelected: (_) => _openPlaceBottomSheet(),
        ),
        FilterChip(
          avatar: const Icon(Icons.filter_list, size: 18),
          label: const Text("Bộ lọc"),
          selected: false,
          onSelected: (_) => _openFilterScreen(),
        ),
      ],
    );
  }
}

void showPlaceFilterBottomSheet(
  BuildContext context,
  String selectedPlace,
  Function(String) onApply,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final options = [
        "Bác sĩ",
        "Bệnh viện",
        "Phòng khám",
        "Trung tâm tiêm chủng",
        "Tất cả",
      ];
      String tempSelected = selectedPlace;

      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () => Navigator.pop(context),
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
                  Opacity(
                    opacity: 0,
                    child: Icon(
                      Icons.exit_to_app,
                      size: 24,
                      color: GlobalColors.textColor,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...options.map(
                          (option) => RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: tempSelected,
                            onChanged:
                                (value) =>
                                    setState(() => tempSelected = value!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onApply(tempSelected);
                            },
                            child: Text("Áp dụng"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(44),
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
      );
    },
  );
}
