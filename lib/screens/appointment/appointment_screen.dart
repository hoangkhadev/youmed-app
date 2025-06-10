import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:my_flutter_app/screens/appointment/appointment_card.dart';
import 'package:my_flutter_app/services/appointment_service.dart';
import 'package:my_flutter_app/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/login_required.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => AppointmentScreenState();
}

class AppointmentScreenState extends State<AppointmentScreen> {
  List<AppointmentModel>? _appointments;
  final appointmentService = AppointmentService();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      initialAppointments();
    }
  }

  Future<void> initialAppointments() async {
    final user = context.read<AuthProvider>().currentUser;

    if (user != null) {
      final result = await appointmentService.getAppointments(user.id);
      if (result != null) {
        setState(() {
          _appointments = result;
        });
      }
    }
  }

  Color getStatusColor(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Color(0xFFF59E0B); // màu cam
      case AppointmentStatus.confirmed:
        return Color(0xFF3B82F6); // xanh dương
      case AppointmentStatus.cancelled:
        return Color(0xFFEF4444); // đỏ
      case AppointmentStatus.done:
        return Color(0xFF047857); // xanh lá
      default:
        return Colors.grey; // fallback nếu null
    }
  }

  String getStatusName(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.pending:
        return 'Chờ duyệt';
      case AppointmentStatus.confirmed:
        return 'Đã duyệt';
      case AppointmentStatus.cancelled:
        return 'Đã hủy';
      case AppointmentStatus.done:
        return 'Đã khám';
      default:
        return 'Chờ duyệt';
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
        title: Text(
          'Lịch khám',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body:
          auth.isLoggedIn
              ? ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _appointments?.length,
                itemBuilder: (context, index) {
                  final appointment = _appointments?[index];
                  if (appointment != null) {
                    return AppointmentCard(
                      status: getStatusName(appointment.status),
                      statusColor: getStatusColor(appointment.status),
                      doctorName: appointment.doctor.user.fullName,
                      doctorImageUrl: appointment.doctor.avatarUrl,
                      timeRange:
                          '${appointment.snapshotTimeSlot.startTime}–${appointment.snapshotTimeSlot.endTime} - ${Utils.formatDate(DateTime.parse(appointment.datetime))}',
                      specialization: appointment.doctor.specializations
                          .map((s) => s.name)
                          .join(', '),
                      patientName: appointment.patient.fullName,
                    );
                  }
                  return null;
                },
              )
              : LoginRequired(),
    );
  }
}
