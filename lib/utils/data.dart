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
