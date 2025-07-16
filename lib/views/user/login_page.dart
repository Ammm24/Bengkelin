import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/viewmodel/auth_viewmodel.dart';
import 'package:flutter_bengkelin/views/user/home_page.dart';
import 'package:flutter_bengkelin/views/user/register_page.dart';
import 'package:flutter_bengkelin/views/user/splash_scren.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/app_color.dart';
import '../../config/pref.dart';
import '../../widget/custom_toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegExp get emailRegex => RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  login() {
    setState(() {
      isLoading = true;
    });

    AuthViewmodel()
        .login(email: _emailController.text, password: _passwordController.text)
        .then((value) async {
          if (!mounted) return;

          if (value.code == 200 && value.data != null) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            // 1. Simpan access_token
            if (value.data["access_token"] != null) {
              await Session().setUserToken(value.data["access_token"]);
              debugPrint(
                'Access Token berhasil disimpan: ${value.data["access_token"]}',
              );
            } else {
              debugPrint(
                'Peringatan: Access Token tidak ditemukan dalam respons login.',
              );
            }

            // 2. Simpan nama pengguna
            if (value.data['user'] != null &&
                value.data['user']['name'] != null) {
              String userName = value.data['user']['name'];
              await prefs.setString('user_name', userName);
              debugPrint('Nama pengguna berhasil disimpan: $userName');
            } else {
              debugPrint(
                'Peringatan: Nama pengguna tidak ditemukan dalam respons login.',
              );
            }

            // 3. Simpan URL foto profil
            if (value.data['user'] != null &&
                value.data['user']['photo_url'] != null) {
              String userPhotoUrl = value.data['user']['photo_url'];
              await prefs.setString('user_photo_url', userPhotoUrl);
              debugPrint('URL foto profil berhasil disimpan: $userPhotoUrl');
            } else {
              debugPrint(
                'Peringatan: URL foto profil tidak ditemukan dalam respons login.',
              );
              await prefs.remove('user_photo_url');
            }

            // Navigasi ke HomePage setelah data disimpan
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          } else {
            showToast(context: context, msg: value.message.toString());
          }
          setState(() {
            isLoading = false;
          });
        })
        .catchError((error) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
          });
          showToast(context: context, msg: "Terjadi kesalahan: $error");
          debugPrint("Error saat login: $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Masuk Akun',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E2A3B),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Masuk ke dalam akun untuk bisa maksimal dalam\nmenggunakan fitur aplikasi.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Alamat Email',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!emailRegex.hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Kata Sandi',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata sandi tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Kata sandi minimal 6 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 2,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A6B6B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Masuk sekarang',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum memiliki akun?',
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar Sekarang',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4A6B6B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // <<< MODIFIKASI PADA TOMBOL 'Nanti Saja'
              TextButton(
                onPressed: () {
                  // Navigasi ke SplashScreen dan hapus semua rute sebelumnya
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const SplashScreen(),
                    ), // <<< Mengarah ke SplashScreen
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Nanti Saja',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              // >>> AKHIR MODIFIKASI
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
