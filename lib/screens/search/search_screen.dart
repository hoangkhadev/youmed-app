import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/screens/search/search_doctordetail.dart';
import 'package:my_flutter_app/services/doctor_service.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

import 'package:my_flutter_app/widgets/doctor_card.dart';
import 'package:my_flutter_app/widgets/filter_chip.dart';
import 'package:my_flutter_app/widgets/loading.dart';
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
  bool isLoading = false;

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
      _fetchDoctors(q: _searchController.text);
    });
  }

  Future<void> _fetchDoctors({String? q = ''}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final doctors = await _doctorService.getAllDoctors(search: q);
      if (doctors!.isNotEmpty) {
        setState(() {
          _doctors = doctors;
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: GlobalColors.whiteColor,
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 65,
        backgroundColor: GlobalColors.mainColor,
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
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

      body:
          isLoading
              ? Loading()
              : Column(
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
                      itemCount: _doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = _doctors[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => DoctorDetail(doctorId: doctor.id),
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
    );
  }
}
