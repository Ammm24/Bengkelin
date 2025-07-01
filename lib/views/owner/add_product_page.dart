// lib/views/owner/add_product_page.dart
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart'; // Pastikan import ini ada dan benar
import 'package:file_picker/file_picker.dart'; // Untuk memilih file

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  PlatformFile? _pickedFile; // Untuk menyimpan informasi file yang dipilih

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Hanya izinkan gambar
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
      });
      debugPrint('File picked: ${_pickedFile!.name}');
    } else {
      // User canceled the picker
      debugPrint('File picking cancelled');
    }
  }

  void _saveProduct() {
    // Implementasi logika penyimpanan produk di sini
    final productName = _productNameController.text;
    final price = _priceController.text;
    final description = _descriptionController.text;

    debugPrint('Product Name: $productName');
    debugPrint('Price: $price');
    debugPrint('Description: $description');
    debugPrint('Picked File: ${_pickedFile?.name ?? "No file"}');

    // TODO: Kirim data ini ke backend atau simpan secara lokal
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Product saved! (Simulated)')));

    // Kembali ke halaman sebelumnya atau reset form
    // Navigator.pop(context);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: const Color(0xFF4F625D), // Warna AppBar
        foregroundColor: Colors.white, // Warna teks dan ikon di AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Media Upload',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E), // Warna teks sesuai desain
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your documents here, and you can upload up...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Area Upload File
            GestureDetector(
              onTap: _pickFile,
              child: DottedBorder(
                // Pastikan Anda memiliki package 'dotted_border'
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 180, // Tinggi area upload
                    width: double.infinity,
                    color: Colors.grey[50], // Latar belakang abu-abu muda
                    child: _pickedFile != null
                        ? Image.file(
                            // Tampilkan gambar yang dipilih
                            // Pastikan Anda menambahkan path_provider dan path package jika menggunakan File
                            // import 'dart:io';
                            // import 'package:path_provider/path_provider.dart';
                            // Untuk demo ini, kita asumsikan _pickedFile.path bisa langsung digunakan
                            // Jika ada masalah di iOS/Android, mungkin perlu tambahan package image_picker atau path.
                            Image.file(
                                  // Jika _pickedFile.path null (jarang tapi mungkin), gunakan placeholder
                                  // ini hanya untuk ilustrasi, di aplikasi nyata perlu penanganan error yang lebih baik.
                                  // Misalnya: File(_pickedFile!.path!),
                                  File(
                                    _pickedFile!.path!,
                                  ), // Requires 'dart:io'
                                  fit: BoxFit.cover,
                                )
                                as File,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload,
                                size: 50,
                                color: Colors.blueGrey,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Drag your file(s) to start uploading',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'OR',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _pickFile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .white, // Warna latar belakang tombol putih
                                  foregroundColor: const Color(
                                    0xFF4F625D,
                                  ), // Warna teks tombol hijau gelap
                                  side: const BorderSide(
                                    color: Color(0xFF4F625D),
                                  ), // Border
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Browse files'),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Input Nama Product
            const Text(
              'Nama Product',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama product',
                border: OutlineInputBorder(
                  // Corrected
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey), // Corrected
                ),
                enabledBorder: OutlineInputBorder(
                  // Corrected
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey), // Corrected
                ),
                focusedBorder: OutlineInputBorder(
                  // Corrected
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF4F625D),
                    width: 1.5,
                  ), // Corrected
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ), // Corrected
              ),
            ),
            const SizedBox(height: 20),

            // Input Harga
            const Text(
              'Harga',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number, // Hanya angka
              decoration: InputDecoration(
                hintText: 'Masukkan harga',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF4F625D),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Deskripsi Product
            const Text(
              'Deskripsi Product',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 5, // Izinkan multi-baris
              decoration: InputDecoration(
                hintText: 'Masukkan deskripsi product',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF4F625D),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Save
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF4F625D,
                  ), // Warna tombol hijau gelap
                  foregroundColor: Colors.white, // Warna teks tombol putih
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
