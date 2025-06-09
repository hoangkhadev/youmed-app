import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/locations_model.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/custom_app_bar.dart';

class SelectedDistrictScreen extends StatefulWidget {
  final List<District> districts;
  final District? selectedDistrict;

  const SelectedDistrictScreen({
    super.key,
    required this.districts,
    this.selectedDistrict,
  });

  @override
  State<SelectedDistrictScreen> createState() => _SelectedDistrictScreenState();
}

class _SelectedDistrictScreenState extends State<SelectedDistrictScreen> {
  late District? selectedDistrict;
  late List<District> filteredDistricts;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDistrict = widget.selectedDistrict;
    filteredDistricts = widget.districts;
    _searchController.addListener(() {
      filterCities(_searchController.text);
    });
  }

  void filterCities(String query) {
    final result =
        widget.districts.where((district) {
          return district.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      filteredDistricts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Chọn Quận/Huyện'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm quận huyện',
                filled: true,
                fillColor: GlobalColors.bgColor,
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Image.asset(GlobalImageIcons.searchIcon, width: 18),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    width: 1,
                    color: GlobalColors.mainColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDistricts.length,
              itemBuilder: (context, index) {
                final district = filteredDistricts[index];
                final isSelected = district.id == selectedDistrict?.id;

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Màu của border
                        width: 0.5, // Độ dày của border
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      district.name,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color:
                            isSelected
                                ? GlobalColors.mainColor
                                : GlobalColors.textColor,
                      ),
                    ),
                    // tileColor: isSelected ? Colors.blue.shade100 : null,
                    trailing:
                        isSelected
                            ? Icon(Icons.check, color: GlobalColors.mainColor)
                            : null,
                    onTap: () {
                      setState(() {
                        selectedDistrict = district;
                        if (selectedDistrict != null) {
                          Navigator.pop(context, selectedDistrict);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
