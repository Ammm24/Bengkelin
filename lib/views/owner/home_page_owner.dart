import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/owner/add_product_page.dart';
import 'package:flutter_bengkelin/views/owner/add_service_page.dart';
// Hapus import ChatsOwnerPage di sini jika Anda tidak lagi menggunakan Navigator.push untuk itu.
// import 'package:flutter_bengkelin/views/owner/chats_owner.dart'; // <-- Pastikan ini chats_owner.dart, bukan chat_page.dart

class HomePageOwner extends StatelessWidget {
  // Tambahkan callback function untuk navigasi tab
  final Function(int) onNavigateToTab;

  const HomePageOwner({
    super.key,
    required this.onNavigateToTab, // Buat parameter ini wajib
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Selamat Datang
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/profile1.png', // Ganti dengan path gambar Anda
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        'Yoga Pratama',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Nama Bengkel
              const Text(
                'Bengkel Udin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 20),

              // Bagian Tambahkan (Add Product, Add Service, Chat)
              const Text(
                'Tambahkan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAddButton(
                    context,
                    icon: Icons.inventory_2_outlined,
                    text: 'Add Product',
                    onTap: () {
                      Navigator.push(
                        // Tetap gunakan push untuk halaman formulir
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddProductPage(),
                        ),
                      );
                    },
                  ),
                  _buildAddButton(
                    context,
                    icon: Icons.build_circle_outlined,
                    text: 'Add Service',
                    onTap: () {
                      Navigator.push(
                        // Tetap gunakan push untuk halaman formulir
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddServicePage(),
                        ),
                      );
                    },
                  ),
                  _buildAddButton(
                    context,
                    icon: Icons.chat_bubble_outline,
                    text: 'Chat',
                    onTap: () {
                      // Panggil callback untuk mengubah tab
                      // Index 1 adalah indeks untuk tab "Chats" di MainWrapperOwner
                      onNavigateToTab(1);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Bagian Grafik Penjualan
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text('Sales'),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text('Profit'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Placeholder untuk grafik
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Grafik Penjualan (Placeholder)',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Bagian Penjualan (List Produk/Servis)
              const Text(
                'Penjualan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 15),
              _buildSaleItem(
                context,
                imagePath:
                    'assets/kaca_mobil.jpg', // Pastikan gambar ada di assets
                productName: 'Kaca Mobil',
                ownerName: 'Yoga Pratama',
                price: 'Rp 55.000',
              ),
              _buildSaleItem(
                context,
                imagePath:
                    'assets/ban_motor.jpg', // Pastikan gambar ada di assets
                productName: 'Ban',
                ownerName: 'Yoga Pratama',
                price: 'Rp 70.00',
              ),
              _buildSaleItem(
                context,
                imagePath: 'assets/kampas_rem.jpg',
                productName: 'Kampas Rem',
                ownerName: 'Yoga Pratama',
                price: 'Rp 70.00',
              ),
              _buildSaleItem(
                context,
                imagePath: 'assets/oli.jpg',
                productName: 'Oli Motor X78D',
                ownerName: 'Bagus Sucakyo',
                price: 'Rp 55.000',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk tombol "Tambahkan"
  Widget _buildAddButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              children: [
                Icon(icon, size: 40, color: const Color(0xFF4F625D)),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk item penjualan
  Widget _buildSaleItem(
    BuildContext context, {
    required String imagePath,
    required String productName,
    required String ownerName,
    required String price,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ownerName,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF4F625D),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
