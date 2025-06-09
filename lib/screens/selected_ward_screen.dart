import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/locations_model.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/custom_app_bar.dart';

class SelectedWardScreen extends StatefulWidget {
  final List<Ward> wards;
  final Ward? selectedWard;

  const SelectedWardScreen({super.key, required this.wards, this.selectedWard});

  @override
  State<SelectedWardScreen> createState() => _SelectedWardScreenState();
}

class _SelectedWardScreenState extends State<SelectedWardScreen> {
  late Ward? selectedWard;
  late List<Ward> filteredwards;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedWard = widget.selectedWard;
    filteredwards = widget.wards;
    _searchController.addListener(() {
      filterwards(_searchController.text);
    });
  }

  void filterwards(String query) {
    final result =
        widget.wards.where((ward) {
          return ward.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      filteredwards = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Chọn Phường/Xã'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm phường xã',
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
              itemCount: filteredwards.length,
              itemBuilder: (context, index) {
                final ward = filteredwards[index];
                final isSelected = ward.id == selectedWard?.id;

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
                      ward.name,
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
                        selectedWard = ward;
                        if (selectedWard != null) {
                          Navigator.pop(context, selectedWard);
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
