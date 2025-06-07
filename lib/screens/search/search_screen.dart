import 'package:flutter/material.dart';
import '../../models/doctor.model.dart';
import '../../screens/search/search_doctordetail.dart';
import '../../utils/global.colors.dart';
import '../../widgets/doctor_card.dart';
import '../../widgets/filter_chip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static final id = 'searchscreen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
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
                child: Row(
                  children: [
                    FilterChipWidget(
                      icon: Icons.compass_calibration,
                      label: "Tất cả",
                    ),
                    SizedBox(width: 8),
                    FilterChipWidget(
                      icon: Icons.location_on_outlined,
                      label: "Nơi khám: Tất cả",
                    ),
                    SizedBox(width: 8),
                    FilterChipWidget(icon: Icons.tune, label: "Bộ lọc"),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DoctorDetail()),
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

final doctors = [
  Doctor(
    id: '1',
    name: 'Vũ Thị Hạnh Thư',
    title: 'BS. CK1',
    avatarUrl: 'assets/images/doctor1.png',
    specialty: 'Sản phụ khoa',
    specialties: ['Sản phụ khoa'],
    position: '',
    experience: 14,
    department: '',
    address: '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
    schedules: [],
    isSaved: false,
    isVerified: true,
  ),
  Doctor(
    id: '2',
    name: 'Hồ Thị Mỹ Ngọc',
    title: 'BS. CK1',
    avatarUrl: 'assets/images/doctor2.png',
    specialty: 'Nhi khoa',
    specialties: ['Nhi khoa'],
    position: '',
    experience: 7,
    department: '',
    address: '63/9A Gò Dầu, Quận Tân Phú, Hồ Chí Minh',
    schedules: [],
    isSaved: true,
    isVerified: false,
  ),
  Doctor(
    id: '3',
    name: 'Vũ Thị Hạnh Thư',
    title: 'BS. CK1',
    avatarUrl: 'assets/images/doctor1.png',
    specialty: 'Sản phụ khoa',
    specialties: ['Sản phụ khoa'],
    position: '',
    experience: 14,
    department: '',
    address: '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
    schedules: [],
    isSaved: false,
    isVerified: true,
  ),
  Doctor(
    id: '4',
    name: 'Vũ Thị Hạnh Thư',
    title: 'BS. CK1',
    avatarUrl: 'assets/images/doctor1.png',
    specialty: 'Sản phụ khoa',
    specialties: ['Sản phụ khoa'],
    position: '',
    experience: 14,
    department: '',
    address: '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
    schedules: [],
    isSaved: false,
    isVerified: true,
  ),
  Doctor(
    id: '5',
    name: 'Vũ Thị Hạnh Thư',
    title: 'BS. CK1',
    avatarUrl: 'assets/images/doctor1.png',
    specialty: 'Sản phụ khoa',
    specialties: ['Sản phụ khoa'],
    position: '',
    experience: 14,
    department: '',
    address: '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
    schedules: [],
    isSaved: false,
    isVerified: true,
  ),
  Doctor(
    id: '6',
    name: 'Vũ Thị Hạnh Thư',
    title: 'BS. CK1',
    avatarUrl: 'assets/images/doctor1.png',
    specialty: 'Sản phụ khoa',
    specialties: ['Sản phụ khoa'],
    position: '',
    experience: 14,
    department: '',
    address: '333 Huỳnh Tấn Phát, Quận 7, Hồ Chí Minh',
    schedules: [],
    isSaved: false,
    isVerified: true,
  ),
];
