import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker
import 'dart:io'; // Untuk menggunakan kelas File (khusus untuk pratinjau gambar)

class AddServicePage extends StatefulWidget {
  // Mengubah ke StatefulWidget
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  PlatformFile? _pickedFile; // Untuk menyimpan file yang dipilih

  // Fungsi untuk memilih file
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type:
          FileType.image, // Contoh: Hanya izinkan memilih gambar untuk service
      allowMultiple: false, // Hanya izinkan memilih satu file
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedFile = result.files.first; // Ambil file pertama jika sukses
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File selected: ${_pickedFile!.name}')),
      );
    } else {
      // User membatalkan pemilihan file
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No file selected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1A2E)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Service', // Judul disesuaikan untuk Service
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Media Upload',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your documents here, and you can upload up...',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            // Media Upload Area
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: EdgeInsets.zero,
              dashPattern: const [8, 4],
              strokeWidth: 2,
              color: Colors.grey[400]!,
              child: Container(
                width: double.infinity,
                height: 180,
                color: Colors.white,
                child:
                    _pickedFile ==
                        null // Cek apakah sudah ada file yang dipilih
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Drag your file(s) to start uploading',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _pickFile, // Panggil fungsi _pickFile
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.blue),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Browse files'),
                          ),
                        ],
                      )
                    : Stack(
                        // Tampilkan file yang dipilih jika ada
                        alignment: Alignment.center,
                        children: [
                          // Tampilkan gambar jika file yang dipilih adalah gambar DAN path-nya tidak null.
                          if (_pickedFile!.path != null &&
                              (_pickedFile!.extension == 'jpg' ||
                                  _pickedFile!.extension == 'jpeg' ||
                                  _pickedFile!.extension == 'png' ||
                                  _pickedFile!.extension == 'gif'))
                            Image.file(
                              File(
                                _pickedFile!.path!,
                              ), // Gunakan '!' karena sudah dipastikan tidak null di 'if'
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          else // Jika bukan gambar atau path-nya null, tampilkan ikon dan nama file
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 50,
                                  color: Colors.grey[600],
                                ), // Ikon generik untuk file
                                const SizedBox(height: 10),
                                Text(
                                  _pickedFile!.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_pickedFile!.size != null)
                                  Text(
                                    '(${(_pickedFile!.size! / 1024).toStringAsFixed(2)} KB)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 4),
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  _pickedFile = null; // Hapus file yang dipilih
                                });
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            child: ElevatedButton.icon(
                              onPressed: _pickFile, // Izinkan ganti file
                              icon: const Icon(Icons.edit),
                              label: const Text('Change File'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black54,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 30),
            // Nama Service Input
            _buildTextField(hintText: 'Nama Service'),
            const SizedBox(height: 20),
            // Harga Input
            _buildTextField(
              hintText: 'Harga',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Deskripsi Service Input
            _buildMultiLineTextField(hintText: 'Deskripsi Service'),
            const SizedBox(height: 40),
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save service logic
                  if (_pickedFile != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Saving service with file: ${_pickedFile!.name}',
                        ),
                      ),
                    );
                    // Lakukan proses upload file ke server di sini
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a file first!'),
                      ),
                    );
                  }
                  // Navigator.pop(context); // Kembali setelah menyimpan jika berhasil
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F625D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
        fillColor: Colors.white,
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

  // Widget pembantu untuk Multi-line TextField (Deskripsi)
  Widget _buildMultiLineTextField({required String hintText}) {
    return TextField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
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
          borderSide: const BorderSide(color: Color(0xFF4F625D), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
