import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/owner/login_page_owner.dart'; // Import jika ingin navigasi ke halaman login owner

class RegisterPageOwner extends StatefulWidget {
  const RegisterPageOwner({super.key});

  @override
  State<RegisterPageOwner> createState() => _RegisterPageOwnerState();
}

class _RegisterPageOwnerState extends State<RegisterPageOwner> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _selectedGender; // Untuk menyimpan pilihan jenis kelamin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1A1A2E),
          ), // Warna ikon back
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Daftar Akun Mitra',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E), // Warna teks judul
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Daftar akun supaya bisa menggunakan fitur\ndidalam aplikasi.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600], // Warna teks deskripsi
              ),
            ),
            const SizedBox(height: 40),
            // Nama Lengkap Input
            _buildTextField(hintText: 'Nama Lengkap'),
            const SizedBox(height: 20),
            // Username Input
            _buildTextField(hintText: 'Username'),
            const SizedBox(height: 20),
            // Jenis Kelamin Dropdown
            _buildGenderDropdown(),
            const SizedBox(height: 20),
            // Alamat Email Input
            _buildTextField(
              hintText: 'Alamat Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Kata Sandi Input
            _buildPasswordField(
              hintText: 'Kata Sandi',
              obscureText: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            const SizedBox(height: 20),
            // Konfirmasi Kata Sandi Input
            _buildPasswordField(
              hintText: 'Konfirmasi Kata Sandi',
              obscureText: _obscureConfirmPassword,
              onToggleVisibility: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            const SizedBox(height: 40),
            // Daftar Button
            SizedBox(
              width: double.infinity,
              height: 55, // Tinggi tombol
              child: ElevatedButton(
                onPressed: () {
                  // Logika pendaftaran untuk mitra
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pendaftaran Mitra Berhasil! (Ini hanya simulasi)',
                      ),
                    ),
                  );
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePageOwner()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F625D), // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ), // Radius border tombol
                  ),
                  elevation: 0, // Tanpa shadow
                ),
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'atau',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 20),
            // Masuk dengan Google Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Masuk dengan Google (Fitur belum diimplementasi)',
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ), // Border abu-abu
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google_logo.png',
                      height: 24,
                      width: 24,
                    ), // Pastikan ada gambar logo Google
                    const SizedBox(width: 10),
                    Text(
                      'Masuk dengan Google',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigasi ke halaman login mitra
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPageOwner(),
                    ),
                  );
                },
                child: Text(
                  'Sudah memiliki akun? masuk sekarang',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  ); // Kembali ke halaman sebelumnya (misal SplashScreen)
                },
                child: Text(
                  'Nanti Saja',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(height: 40), // Spasi di bagian bawah
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk TextField biasa
  Widget _buildTextField({
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F625D), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  // Widget pembantu untuk Password Field
  Widget _buildPasswordField({
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4F625D), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[500],
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }

  // Widget pembantu untuk Dropdown Jenis Kelamin
  Widget _buildGenderDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.transparent,
        ), // Border transparan default
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGender,
          hint: Text(
            'Jenis Kelamin',
            style: TextStyle(color: Colors.grey[500]),
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
          items: <String>['Laki-laki', 'Perempuan']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toList(),
        ),
      ),
    );
  }
}
