import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/locations_model.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/custom_app_bar.dart';

class SelectedCityScreen extends StatefulWidget {
  final List<City> cities;
  final City? selectedCity;

  const SelectedCityScreen({
    super.key,
    required this.cities,
    this.selectedCity,
  });

  @override
  State<SelectedCityScreen> createState() => _SelectedCityScreenState();
}

class _SelectedCityScreenState extends State<SelectedCityScreen> {
  late City? selectedCity;
  late List<City> filteredCities;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCity = widget.selectedCity;
    filteredCities = widget.cities;
    _searchController.addListener(() {
      filterCities(_searchController.text);
    });
  }

  void filterCities(String query) {
    final result =
        widget.cities.where((city) {
          return city.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      filteredCities = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Chọn Tỉnh thành'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tỉnh thành',
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
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                final city = filteredCities[index];
                final isSelected = city.id == selectedCity?.id;

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
                      city.name,
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
                        selectedCity = city;
                        if (selectedCity != null) {
                          Navigator.pop(context, selectedCity);
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
