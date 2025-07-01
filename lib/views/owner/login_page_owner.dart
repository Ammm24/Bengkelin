import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/owner/buttom_navbar.dart';
import 'package:flutter_bengkelin/views/owner/register_page_owner.dart'; // Untuk navigasi ke Daftar Akun Mitra

class LoginPageOwner extends StatefulWidget {
  const LoginPageOwner({super.key});

  @override
  State<LoginPageOwner> createState() => _LoginPageOwnerState();
}

class _LoginPageOwnerState extends State<LoginPageOwner> {
  bool _isPasswordVisible = false; // Untuk mengontrol visibilitas password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masuk Akun Mitra', // Judul
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Masuk ke dalam akun untuk bisa maksimal dalam menggunakan fitur aplikasi.', // Deskripsi
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),

            // Input Alamat Email
            _buildTextField(
              hintText: 'Alamat Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Input Kata Sandi
            _buildTextField(
              hintText: 'Kata Sandi',
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Masuk Sekarang
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implementasi logika login
                  // Jika login berhasil, navigasi ke MainWrapperOwner
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainWrapperOwner(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F625D), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Masuk Sekarang',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Belum memiliki akun? Daftar Sekarang
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPageOwner(),
                    ),
                  );
                },
                child: Text(
                  'Belum memiliki akun? Daftar Sekarang', // Teks
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Nanti Saja
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // TODO: Logika untuk "Nanti Saja", mungkin langsung ke MainWrapperOwner tanpa login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainWrapperOwner(),
                    ),
                  );
                },
                child: const Text(
                  'Nanti Saja', // Teks
                  style: TextStyle(
                    color: Color(0xFF4F625D),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F625D), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
