import 'package:my_flutter_app/utils/gobal.images.icons.dart';

final List<Map<String, String>> features = [
  {'title': 'Đặt khám bác sĩ', 'image': GlobalImageIcons.doctorIcon},
  {'title': 'Đặt khám phòng khám', 'image': GlobalImageIcons.stethoscopeIcon},
  {'title': 'Đặt khám bệnh viện', 'image': GlobalImageIcons.hospitalIcon},
  {'title': 'Chat với bác sĩ', 'image': GlobalImageIcons.chatIcon},
  {'title': 'Gọi video với bác sĩ', 'image': GlobalImageIcons.phoneIcon},
  {'title': 'Kết quả khám', 'image': GlobalImageIcons.bagIcon},
  {'title': 'Đặt lịch tiêm chủng', 'image': GlobalImageIcons.protectionIcon},
  {'title': 'Đặt lịch xét nghiệm', 'image': GlobalImageIcons.vaccineIcon},
  {'title': 'Cộng đồng', 'image': GlobalImageIcons.groupIcon},
];

final List<Map<String, String>> specialties = [
  {'title': 'Y học cổ truyền', 'image': GlobalImageIcons.yHocCoTruyenIcon},
  {'title': 'Lao - bệnh phổi', 'image': GlobalImageIcons.laoBenhPhoiIcon},
  {'title': 'Y học thể thao', 'image': GlobalImageIcons.yHocTheThaoIcon},
  {'title': 'Cơ xương khớp', 'image': GlobalImageIcons.coXuongKhopIcon},
  {'title': 'Sản phụ khoa', 'image': GlobalImageIcons.sanPhuKhoaIcon},
  {'title': 'Nhãn khoa', 'image': GlobalImageIcons.nhanKhoaIcon},
  {'title': 'Nam khoa', 'image': GlobalImageIcons.namKhoaIcon},
  {'title': 'Vô sinh hiếm muộn', 'image': GlobalImageIcons.voSinhHiemMuonIcon},
  {'title': 'Ngoại tiết niệu', 'image': GlobalImageIcons.ngoaiTietNieuIcon},
  {'title': 'Ngoại thần kinh', 'image': GlobalImageIcons.ngoaiThanKinhIcon},
  {'title': 'Nội tổng quát', 'image': GlobalImageIcons.noiTongQuatIcon},
  {'title': 'Ngoại niệu', 'image': GlobalImageIcons.ngoaiNieuIcon},
  {'title': 'Dinh dưỡng', 'image': GlobalImageIcons.dinhDuongIcon},
  {'title': 'Tiêu hóa', 'image': GlobalImageIcons.tieuHoaIcon},
  {'title': 'Nhi khoa', 'image': GlobalImageIcons.nhiKhoaIcon},
  {'title': 'Da liễu', 'image': GlobalImageIcons.daLieuIcon},
  {
    'title': 'Ngoại lồng ngực - mạch máu',
    'image': GlobalImageIcons.ngoaiLongNgucMachMauIcon,
  },
  {
    'title': 'Chẩn đoán hình ảnh',
    'image': GlobalImageIcons.chanDoanHinhAnhIcon,
  },
  {'title': 'Ngôn ngữ trị liệu', 'image': GlobalImageIcons.ngonNguTriLieuIcon},
  {'title': 'Răng - Hàm - Mặt', 'image': GlobalImageIcons.rangHamMatIcon},
  {'title': 'Nội thần kinh', 'image': GlobalImageIcons.noiThanKinhIcon},
  {'title': 'Tai - Mũi - Họng', 'image': GlobalImageIcons.taiMuiHongIcon},
  {'title': 'Ung bướu', 'image': GlobalImageIcons.ungBuouIcon},
  {'title': 'Tim mạch', 'image': GlobalImageIcons.timMachIcon},
  {'title': 'Lão khoa', 'image': GlobalImageIcons.laoKhoaIcon},
  {
    'title': 'Chấn thương chỉnh hình',
    'image': GlobalImageIcons.chanThuongChinhHinhIcon,
  },
  {'title': 'Hồi sức cấp cứu', 'image': GlobalImageIcons.hoiSucCapCuuIcon},
  {'title': 'Ngoại tổng quát', 'image': GlobalImageIcons.ngoaiTongQuatIcon},
  {'title': 'Gây mê hồi sức', 'image': GlobalImageIcons.gayMeHoiSucIcon},
  {'title': 'Y học dự phòng', 'image': GlobalImageIcons.yHocDuPhongIcon},
  {'title': 'Truyền nhiễm', 'image': GlobalImageIcons.truyenNhiemIcon},
  {'title': 'Nội thận', 'image': GlobalImageIcons.noiThanIcon},
  {'title': 'Nội tiết', 'image': GlobalImageIcons.noiTietIcon},
  {'title': 'Tâm thần', 'image': GlobalImageIcons.tamThanIcon},
  {'title': 'Hô hấp', 'image': GlobalImageIcons.hoHapIcon},
  {'title': 'Xét nghiệm', 'image': GlobalImageIcons.xetNghiemIcon},
  {'title': 'Huyết học', 'image': GlobalImageIcons.huyetHocIcon},
  {'title': 'Tâm lý', 'image': GlobalImageIcons.tamLyIcon},
  {
    'title': 'Phẩu thuật tạo hình (Thẩm mỹ)',
    'image': GlobalImageIcons.thamMyIcon,
  },
  {'title': 'Đa khoa', 'image': GlobalImageIcons.daKhoaIcon},
  {
    'title': 'Phục hồi chức năng (Vật lý trị liệu)',
    'image': GlobalImageIcons.phucHoiChucNangVatLyTriLieuIcon,
  },
];

final List<Map<String, dynamic>> doctors = [
  {
    'name': 'Lê Thị Minh Hồng',
    'title': 'BS. CK2',
    'avatarUrl': GlobalImageIcons.doctor1,
    'specialty': 'Nội thận',
    'specialties': ['Nhi khoa'],
    'position': 'Phó giám đốc bệnh viện nhi đồng 2',
    'experience': 25,
    'address': '250 Nguyễn Xí, Phường 13, Quận Bình Thạnh, Hồ Chí Minh',
    'introduce':
        'Bác sĩ Nguyễn Văn A có hơn 15 năm kinh nghiệm trong điều trị các bệnh lý liên quan đến thận và tiết niệu.',
    'schedules': [
      {
        'date': '2025-06-03',
        'dayOfWeek': 'Tuesday',
        'timeSlots': [
          {
            'period': 'morning',
            'slots': [
              {'start': '08:00', 'end': '08:30', 'isAvailable': true},
              {'start': '08:30', 'end': '09:00', 'isAvailable': false},
              {'start': '09:00', 'end': '09:30', 'isAvailable': true},
            ],
          },
          {
            'period': 'afternoon',
            'slots': [
              {'start': '13:00', 'end': '13:30', 'isAvailable': true},
              {'start': '13:30', 'end': '14:00', 'isAvailable': true},
            ],
          },
        ],
      },
    ],
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor2,
    'specialty': 'Nội thận',
    'specialties': ['Tiêu hóa'],
    'position': 'Phó giám đốc bệnh viện chợ rẫy',
    'experience': 25,
    'address': '250 Nguyễn Xí, Phường 13, Quận Bình Thạnh, Hồ Chí Minh',
    'introduce':
        'Bác sĩ Nguyễn Văn A có hơn 15 năm kinh nghiệm trong điều trị các bệnh lý liên quan đến thận và tiết niệu.',
    'schedules': [
      {
        'date': '2025-06-03',
        'dayOfWeek': 'Tuesday',
        'timeSlots': [
          {
            'period': 'morning',
            'slots': [
              {'start': '08:00', 'end': '08:30', 'isAvailable': true},
              {'start': '08:30', 'end': '09:00', 'isAvailable': false},
              {'start': '09:00', 'end': '09:30', 'isAvailable': true},
            ],
          },
          {
            'period': 'afternoon',
            'slots': [
              {'start': '13:00', 'end': '13:30', 'isAvailable': true},
              {'start': '13:30', 'end': '14:00', 'isAvailable': true},
            ],
          },
        ],
      },
    ],
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor3,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor4,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor5,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor6,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor7,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor8,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor9,
  },
  {
    'name': 'Lâm Việt Trung',
    'title': 'PGS. TS. BS',
    'avatarUrl': GlobalImageIcons.doctor10,
  },
];

final List<Map<String, String>> hospitals = [
  {
    'name': 'Bệnh viện Răng Hàm Mặt TP.HCM',
    'image': GlobalImageIcons.rangHamMat,
    'address': '263-265 Trần Hưng Đạo, P. Cô Giang, Q.1, TP.HCM',
  },
  {
    'name': 'Bệnh viện Y Học Cổ Truyền TP.HCM',
    'image': GlobalImageIcons.yHocCoTruyen,
    'address': '179 Nam Kỳ Khởi Nghĩa, P.7, Q.3, TP.HCM',
  },
  {
    'name': 'Bệnh viện Lê Văn Thịnh',
    'image': GlobalImageIcons.leVanThinh,
    'address': '130 Lê Văn Thịnh , P. Bình Trưng Tây, TP. Thủ Đức, TP.HCM',
  },
  {
    'name': 'Bệnh viện Quận 4',
    'image': GlobalImageIcons.quan4,
    'address': '65 Bến Vân Đồn, Phường 12, Quận 4, Thành phố Hồ Chí Minh',
  },
  {
    'name': 'Bệnh viện Quân Y 175',
    'image': GlobalImageIcons.quanY175,
    'address': '786 Nguyễn Kiệm, P.3, Q. Gò Vấp, TP.HCM',
  },
  {
    'name': 'Bệnh viện Ung Bướu TPHCM',
    'image': GlobalImageIcons.ungBuou,
    'address': '47 Nguyễn Huy Lượng, P. 14, Q. Bình Thạnh, TP.HCM',
  },
  {
    'name': 'Bệnh viện Tai Mũi Họng TPHCM',
    'image': GlobalImageIcons.taiMuiHong,
    'address': '153-155-157 Trần Quốc Thảo, Phường 9, Quận 3, TP.HCM',
  },
  {
    'name': 'Bệnh viện Bình Tân',
    'image': GlobalImageIcons.binhTan,
    'address':
        '809 Hương Lộ 2, Phường Bình Trị Đông A, Quận Bình Tân, TP. Hồ Chí Minh',
  },
  {
    'name': 'Bệnh viện An Bình',
    'image': GlobalImageIcons.anBinh,
    'address': '146 An Binh, Phường 7, Quận 5, Thành phố Hồ Chí Minh',
  },
  {
    'name': 'Bệnh viện Huyện Nhà Bè',
    'image': GlobalImageIcons.nhaBe,
    'address': '281A Lê Văn Lương, Ấp 3, Xã Phước Kiển, Huyện Nhà Bè',
  },
];

final List<Map<String, String>> clinics = [
  {
    'name': 'Phòng khám Hello Doctor',
    'image': GlobalImageIcons.helloDoctor,
    'address': '152/6 Thành Thái, P.12, Q.10, TP.HCM',
  },
  {
    'name': 'Shine Clinic By TS.BS Trần Ngọc Ánh since 1987',
    'image': GlobalImageIcons.shine,
    'address': '06 Trương Quyền, P.6, Q.3, TP.HCM',
  },
  {
    'name': 'Phòng khám Sản Phụ Khoa 13 Cao Thắng',
    'image': GlobalImageIcons.sanPhuKhoa13,
    'address': '13 Cao Thắng, P.5, Q.3, TP.HCM',
  },
  {
    'name': 'Phòng Khám Phụ Sản 315 Quận Thủ Đức',
    'image': GlobalImageIcons.phuSan315,
    'address': '175 Lê Văn Việt, P. Hiệp Phú, Q.9, Q.Thủ Đức, TP.HCM',
  },
  {
    'name': 'Phòng khám SIM Medical Center Tân Phú',
    'image': GlobalImageIcons.simMed,
    'address':
        'Toà nhà Richstar 2 - RS5, 239-241 đường Hòa Bình, P. Hiệp Tân, Q.Tân Phú, TP.HCM',
  },
  {
    'name': 'Phòng khám Nhi Mỹ Mỹ',
    'image': GlobalImageIcons.myMy,
    'address': '105/10 Nguyễn Thị Tú, P. Bình Hưng Hòa B, Q. Bình Tân, TP.HCM',
  },
  {
    'name': 'Phòng Khám Nhi Đồng 315 Quận 10',
    'image': GlobalImageIcons.nhiDong315,
    'address': '307 Tô Hiến Thành, P. 13, Q. 10, TP.HCM',
  },
  {
    'name': 'ALMA Clinic by TS.BS Trần Ngọc Ánh',
    'image': GlobalImageIcons.alma,
    'address': '290 Nguyễn Thị Minh Khai, P.5, Q.3, TP. HCM',
  },
  {
    'name': 'Hệ thống tiêm chủng VNVC',
    'image': GlobalImageIcons.vnvc,
    'address': 'Trên toàn quốc',
  },
  {
    'name': 'Hệ thống tiêm chủng Long Châu',
    'image': GlobalImageIcons.longChau,
    'address': 'Trên toàn quốc',
  },
];
