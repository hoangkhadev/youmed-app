import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:my_flutter_app/models/medical_record_model.dart';
import 'package:my_flutter_app/services/appointment_service.dart';
import 'package:my_flutter_app/services/medical_record_service.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/utils.dart';
import 'package:my_flutter_app/widgets/loading.dart';
import 'package:my_flutter_app/widgets/overlay.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';
import 'package:my_flutter_app/widgets/toast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppointmentDetail extends StatefulWidget {
  static final id = 'appointmentdetail_screen';
  const AppointmentDetail({super.key});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  late String appointmentId;
  MedicalRecordModel? medicalRecord;
  bool _isInitialized = false;
  bool isLoading = false;
  final loading = LoadingOverlay();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as String;
      appointmentId = args;
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadMedicalRecord();
      });
    }
  }

  Future<void> handleCancelled() async {
    try {
      loading.show(context);
      final appointmentService = AppointmentService();
      await appointmentService.cancleAppointment(appointmentId);

      if (!mounted) return;
      loading.hide();
      await Toast.show(
        context: context,
        message: 'Huỷ lịch hẹn thành công',
        type: ToastType.success,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        loading.hide();
        Toast.show(
          context: context,
          message: e.toString(),
          type: ToastType.error,
        );
      }
    }
  }

  IconData getStatusIcon(AppointmentStatus? status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Icons.access_time;
      case AppointmentStatus.confirmed:
        return Icons.check_circle;
      case AppointmentStatus.done:
        return Icons.check_circle_outline;
      case AppointmentStatus.cancelled:
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  Future<void> loadMedicalRecord() async {
    try {
      setState(() {
        isLoading = true;
      });
      final medicalRecordService = MedicalRecordService();
      final result = await medicalRecordService.getMedicalRecordByAppointmentId(
        appointmentId,
      );
      if (result != null) {
        setState(() {
          isLoading = false;
          medicalRecord = result;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        Toast.show(
          context: context,
          message: e.toString(),
          type: ToastType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0, // ẩn AppBar
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_outlined, size: 20),
        ),
      ),
      body:
          isLoading || medicalRecord == null
              ? Loading()
              : Padding(
                padding: EdgeInsets.only(bottom: 30, left: 12, right: 12),
                child: ScrollableScreenWrapper(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Icon(
                              getStatusIcon(medicalRecord!.appointment.status),
                              color: Utils.getStatusColor(
                                medicalRecord!.appointment.status,
                              ),
                              size: 32,
                            ),
                            SizedBox(height: 8),
                            Text(
                              Utils.getStatusName(
                                medicalRecord!.appointment.status,
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Utils.getStatusColor(
                                  medicalRecord!.appointment.status,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "STT",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              0,
                                              0,
                                              0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          medicalRecord!
                                              .appointment
                                              .appointmentNumber
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: QrImageView(
                                        data: medicalRecord!.appointment.id!,
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 32),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        medicalRecord!.doctor.avatarUrl,
                                      ),
                                      radius: 35,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bác sĩ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            medicalRecord!
                                                .appointment
                                                .doctor
                                                .user
                                                .fullName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            medicalRecord!
                                                .appointment
                                                .doctor
                                                .user
                                                .address,
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                45,
                                                45,
                                                45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                InfoRow(
                                  title: "Mã lịch khám",
                                  value: medicalRecord!.appointment.id!,
                                ),
                                InfoRow(
                                  title: "Ngày khám",
                                  value: Utils.formatDateFromString(
                                    medicalRecord!.appointment.datetime,
                                  ),
                                ),
                                InfoRow(
                                  title: "Giờ khám",
                                  value:
                                      "${medicalRecord!.appointment.snapshotTimeSlot.startTime} - ${medicalRecord!.appointment.snapshotTimeSlot.endTime} (${medicalRecord!.appointment.snapshotTimeSlot.session == 'morning' ? 'Buổi sáng' : 'Buổi chiều'})",
                                  valueColor: Colors.green,
                                ),
                                InfoRow(
                                  title: "Chuyên khoa",
                                  value: medicalRecord!
                                      .appointment
                                      .doctor
                                      .specializations
                                      .map((s) => s.name)
                                      .join(', '),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      "THÔNG TIN BỆNH NHÂN",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),
                                InfoRow(
                                  title: "Họ và tên",
                                  value:
                                      medicalRecord!
                                          .appointment
                                          .patient
                                          .fullName,
                                ),
                                InfoRow(
                                  title: "Ngày sinh",
                                  value:
                                      medicalRecord!
                                          .appointment
                                          .patient
                                          .dobFormated,
                                ),
                                InfoRow(
                                  title: "Giới tính",
                                  value:
                                      medicalRecord!
                                                  .appointment
                                                  .patient
                                                  .gender ==
                                              'male'
                                          ? 'Nam'
                                          : 'Nữ',
                                ),
                                InfoRow(
                                  title: "Số điện thoại",
                                  value:
                                      medicalRecord!.appointment.patient.phone,
                                ),
                                InfoRow(
                                  title: "Triệu chứng",
                                  value: medicalRecord!.symptoms ?? "",
                                ),
                                InfoRow(
                                  title: "Chẩn đoán",
                                  value: medicalRecord!.diagnosis ?? "",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),

                      if (medicalRecord!.appointment.status ==
                          AppointmentStatus.pending)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: handleCancelled,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Hủy lịch hẹn',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey, width: 1.5),
                            ),
                          ),
                          child: Text(
                            'Quay lại',
                            style: TextStyle(
                              color: GlobalColors.textColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const InfoRow({
    required this.title,
    required this.value,
    this.valueColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(color: valueColor ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
