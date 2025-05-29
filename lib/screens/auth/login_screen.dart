import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/screens/home/home_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';
import 'package:my_flutter_app/widgets/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static final id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text.trim();
      final password = _passwordController.text;

      if (phone == '0342333084' && password == '123456') {
        await Toast.show(
          context: context,
          message: 'Đăng nhập thành công!',
          type: ToastType.success,
          duration: 2,
        );

        if (mounted) {
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      } else {
        Toast.show(
          context: context,
          message: 'Số điện thoại hoặc mật khẩu không đúng!',
          type: ToastType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: GlobalColors.subTextColor,
                  ),
                ),

                SizedBox(height: 30),

                Image.asset(GlobalImageIcons.authLogo, width: 150),
                SizedBox(height: 20),
                Text(
                  'Thông tin đăng nhập',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 16),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: '0901234567',
                          hintStyle: GoogleFonts.nunito(
                            color: GlobalColors.subTextColor,
                            fontWeight: FontWeight.w800,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.mainColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: 'Nhập mật khẩu',
                          hintStyle: GoogleFonts.nunito(
                            color: GlobalColors.subTextColor,
                            fontWeight: FontWeight.w800,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            color:
                                _isObscure
                                    ? GlobalColors.subTextColor
                                    : GlobalColors.textColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.mainColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          } else if (value.length < 6) {
                            return 'Mật khẩu phải từ 6 ký tự';
                          }
                          return null;
                        },
                      ),

                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              GlobalColors.mainColor.withValues(alpha: 0.05),
                            ),
                          ),
                          child: Text(
                            'Quên mật khẩu?',
                            style: GoogleFonts.nunito(
                              color: GlobalColors.subTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: GlobalColors.mainColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: GlobalColors.mainColor,
                  ),
                  child: Text(
                    'Đăng ký tài khoản',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: GlobalColors.mainColor,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: GlobalColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Đăng nhập',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: GlobalColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
