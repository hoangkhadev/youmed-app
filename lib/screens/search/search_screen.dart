import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/screens/search/search_doctordetail.dart';
import 'package:my_flutter_app/services/doctor_service.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

import 'package:my_flutter_app/widgets/doctor_card.dart';
import 'package:my_flutter_app/widgets/filter_chip.dart';
import 'package:my_flutter_app/widgets/overlay.dart';
import 'package:my_flutter_app/widgets/toast.dart';

class SearchScreen extends StatefulWidget {
  static final id = 'search_screen';
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final DoctorService _doctorService = DoctorService();
  List<DoctorModel> _doctors = [];
  List<DoctorModel> filteredDoctors = [];
  final loading = LoadingOverlay();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDoctors();
    });
    _searchController.addListener(() {
      filtersDoctor(_searchController.text);
    });
  }

  void filtersDoctor(String query) {
    final result =
        _doctors.where((d) {
          final name = d.user.fullName.toLowerCase();
          final specialty =
              d.specializations.map((e) => e.name.toLowerCase()).toList();
          final q = query.toLowerCase();
          final matchSpecialty = specialty.any((spec) => spec.contains(q));

          return name.contains(q) || matchSpecialty;
        }).toList();

    setState(() {
      filteredDoctors = result;
    });
  }

  Future<void> _fetchDoctors() async {
    try {
      loading.show(context);
      final doctors = await _doctorService.getAllDoctors();
      if (doctors.isNotEmpty) {
        loading.hide();
        setState(() {
          _doctors = doctors;
          filteredDoctors = doctors;
        });
      }
    } catch (e) {
      loading.hide();
      if (!mounted) return;
      await Toast.show(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: GlobalColors.whiteColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: GlobalColors.mainColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.indigo[900],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    autofocus: true,
                    style: TextStyle(color: GlobalColors.whiteColor),
                    decoration: InputDecoration(
                      hintText: "Tên bác sĩ, triệu chứng, chuyên khoa",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: GlobalColors.whiteColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.white60),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FilterChipsRow(),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoctorDetail(doctor: doctor),
                        ),
                      );
                    },
                    child: DoctorCard(doctor: doctor),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// final doctors = [
//   {
//     'id': '1',
//     'name': 'Vũ Thị Hạnh Thư',
//     'title': 'BS. CK1',
//     'avatarUrl': 'assets/images/doctor1.png',
//     'specialty': 'Sản phụ khoa',
//     'specialties': ['Sản phụ khoa'],
//     'position': '',
//     'experience': 14,
//     'department': '',
//     'address': '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
//     'schedules': [],
//     'isSaved': false,
//     'isVerified': true,
//   },
//   {
//     'id': '2',
//     'name': 'Hồ Thị Mỹ Ngọc',
//     'title': 'BS. CK1',
//     'avatarUrl': 'assets/images/doctor2.png',
//     'specialty': 'Nhi khoa',
//     'specialties': ['Nhi khoa'],
//     'position': '',
//     'experience': 7,
//     'department': '',
//     'address': '63/9A Gò Dầu, Quận Tân Phú, Hồ Chí Minh',
//     'schedules': [],
//     'isSaved': true,
//     'isVerified': false,
//   },
//   {
//     'id': '3',
//     'name': 'Vũ Thị Hạnh Thư',
//     'title': 'BS. CK1',
//     'avatarUrl': 'assets/images/doctor1.png',
//     'specialty': 'Sản phụ khoa',
//     'specialties': ['Sản phụ khoa'],
//     'position': '',
//     'experience': 14,
//     'department': '',
//     'address': '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
//     'schedules': [],
//     'isSaved': false,
//     'isVerified': true,
//   },
//   {
//     'id': '4',
//     'name': 'Vũ Thị Hạnh Thư',
//     'title': 'BS. CK1',
//     'avatarUrl': 'assets/images/doctor1.png',
//     'specialty': 'Sản phụ khoa',
//     'specialties': ['Sản phụ khoa'],
//     'position': '',
//     'experience': 14,
//     'department': '',
//     'address': '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
//     'schedules': [],
//     'isSaved': false,
//     'isVerified': true,
//   },
//   {
//     'id': '5',
//     'name': 'Vũ Thị Hạnh Thư',
//     'title': 'BS. CK1',
//     'avatarUrl': 'assets/images/doctor1.png',
//     'specialty': 'Sản phụ khoa',
//     'specialties': ['Sản phụ khoa'],
//     'position': '',
//     'experience': 14,
//     'department': '',
//     'address': '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
//     'schedules': [],
//     'isSaved': false,
//     'isVerified': true,
//   },
//   {
//     'id': '6',
//     'name': 'Vũ Thị Hạnh Thư',
//     'title': 'BS. CK1',
//     'avatarUrl': 'assets/images/doctor1.png',
//     'specialty': 'Sản phụ khoa',
//     'specialties': ['Sản phụ khoa'],
//     'position': '',
//     'experience': 14,
//     'department': '',
//     'address': '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
//     'schedules': [],
//     'isSaved': false,
//     'isVerified': true,
//   },
// ];
