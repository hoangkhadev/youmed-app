import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor.model.dart';
import 'package:my_flutter_app/models/time_slot.model.dart';

class DoctorProvider extends ChangeNotifier {
  // Danh sách bác sĩ
  List<Doctor> _doctors = [];

  // Getter
  List<Doctor> get doctors => _doctors;

  // Bác sĩ đang xem/được chọn
  Doctor? _selectedDoctor;
  Doctor? get selectedDoctor => _selectedDoctor;

  // Ngày được chọn
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  // Khung giờ được chọn
  TimeSlot? _selectedTimeSlot;
  TimeSlot? get selectedTimeSlot => _selectedTimeSlot;

  void loadDoctors() {
    // call api lấy tất cả doctor
    _doctors = [];
  }

  void selectDoctor(Doctor doctor) {
    _selectedDoctor = doctor;
    _selectedDate = null;
    _selectedTimeSlot = null;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _selectedTimeSlot = null;
    notifyListeners();
  }

  void selectTimeSlot(TimeSlot slot) {
    _selectedTimeSlot = slot;
    notifyListeners();
  }

  void toggleSaveDoctor(String doctorId) {
    final index = _doctors.indexWhere((d) => d.id == doctorId);
    if (index != -1) {
      _doctors[index] = _doctors[index].copyWith(
        isSaved: !_doctors[index].isSaved,
      );
      notifyListeners();
    }
  }

  void bookAppointment(BuildContext context) async {
    if (_selectedDoctor != null &&
        _selectedDate != null &&
        _selectedTimeSlot != null) {
      // call api đặt lịch
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Đặt khám thành công với ${_selectedDoctor!.name} vào ${_selectedTimeSlot!.display}',
          ),
        ),
      );
    }
  }
}
