import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:my_flutter_app/screens/appointment/appointment_card.dart';
import 'package:my_flutter_app/screens/appointment/appointment_detail.dart';
import 'package:my_flutter_app/screens/appointment/appointment_empty.dart';
import 'package:my_flutter_app/services/appointment_service.dart';
import 'package:my_flutter_app/utils/utils.dart';
import 'package:my_flutter_app/widgets/loading.dart';
import 'package:my_flutter_app/widgets/toast.dart';
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
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      initialAppointments();
    }
  }

  Future<void> initialAppointments() async {
    try {
      final user = context.read<AuthProvider>().currentUser;
      setState(() {
        isLoading = true;
      });
      if (user != null) {
        final result = await appointmentService.getAppointments(user.id);
        if (result != null) {
          setState(() {
            _appointments = result;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      Toast.show(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
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
              ? isLoading
                  ? Loading()
                  : _appointments?.isEmpty ?? true
                  ? AppointmentEmpty()
                  : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _appointments?.length,
                    itemBuilder: (context, index) {
                      final appointment = _appointments?[index];
                      if (appointment != null) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              AppointmentDetail.id,
                              arguments: appointment.id,
                            );
                            setState(() {});
                          },
                          child: AppointmentCard(
                            status: Utils.getStatusName(appointment.status),
                            statusColor: Utils.getStatusColor(
                              appointment.status,
                            ),
                            doctorName: appointment.doctor.user.fullName,
                            doctorImageUrl: appointment.doctor.avatarUrl,
                            timeRange:
                                '${appointment.snapshotTimeSlot.startTime}–${appointment.snapshotTimeSlot.endTime} - ${Utils.formatDate(DateTime.parse(appointment.datetime))}',
                            specialization: appointment.doctor.specializations
                                .map((s) => s.name)
                                .join(', '),
                            patientName: appointment.patient.fullName,
                          ),
                        );
                      }
                      return null;
                    },
                  )
              : LoginRequired(),
    );
  }
}
