// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/user/chat_page.dart';
import 'package:flutter_bengkelin/views/user/product_page.dart';
import 'package:flutter_bengkelin/views/user/service_page.dart';
// ... (imports halaman lain seperti chats_page.dart, products_page.dart, services_page.dart)

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Indeks halaman yang sedang aktif

  // Data dummy untuk bengkel terdekat (data asli)
  final List<Map<String, String>> allNearbyWorkshops = [
    // ... data kamu ...
    {
      'name': 'Bengkel Udin',
      'distance': '100 M dari lokasi kamu',
      'image': 'assets/bengkel1.jpg',
    },
    {
      'name': 'Bengkel Samsu',
      'distance': '500 M dari lokasi kamu',
      'image': 'assets/bengkel2.jpg',
    },
    {
      'name': 'Bengkel Jaya',
      'distance': '200 M dari lokasi kamu',
      'image': 'assets/bengkel3.jpg',
    },
    {
      'name': 'Bengkel Cahaya',
      'distance': '300 M dari lokasi kamu',
      'image': 'assets/bengkel1.jpg',
    },
    {
      'name': 'Bengkel Maju',
      'distance': '600 M dari lokasi kamu',
      'image': 'assets/bengkel2.jpg',
    },
    {
      'name': 'Bengkel Sejahtera',
      'distance': '150 M dari lokasi kamu',
      'image': 'assets/bengkel3.jpg',
    },
  ];

  // Data dummy untuk produk rekomendasi (data asli)
  final List<Map<String, String>> allRecommendedProducts = [
    {
      'name': 'Oil Motor MPX2',
      'shop': 'Bengkel Pak Jamil',
      'price': 'Rp 55.000',
      'image': 'assets/oli.jpg',
    },
    {
      'name': 'Spion Mobil Xenia',
      'shop': 'Bengkel Pak Jamil',
      'price': 'Rp 1.495.000',
      'image': 'assets/kaca_mobil.jpg',
    },
    {
      'name': 'Ban Motor Michelin',
      'shop': 'Toko Ban Abadi',
      'price': 'Rp 350.000',
      'image': 'assets/ban_motor.jpg',
    },
    {
      'name': 'Kampas Rem Depan',
      'shop': 'Bengkel Jaya Raya',
      'price': 'Rp 120.000',
      'image': 'assets/kampas_rem.jpg',
    },
    {
      'name': 'Busi Motor NGK',
      'shop': 'Toko Sparepart Cepat',
      'price': 'Rp 30.000',
      'image': 'assets/busi.jpg',
    },
  ];

  // Data dummy untuk rekomendasi bengkel (data asli)
  final List<Map<String, String>> allRecommendedWorkshops = [
    // ... data kamu ...
    {
      'name': 'Bengkel Pak Jamil',
      'location': 'Jakarta',
      'image': 'assets/bengkel1.jpg',
    },
    {
      'name': 'Bengkel Sumber Jaya',
      'location': 'Surabaya',
      'image': 'assets/bengkel2.jpg',
    },
    {
      'name': 'Bengkel Maju Bersama',
      'location': 'Bandung',
      'image': 'assets/bengkel3.jpg',
    },
  ];

  // List yang akan ditampilkan (hasil filter)
  List<Map<String, String>> filteredNearbyWorkshops = [];
  List<Map<String, String>> filteredRecommendedProducts = [];
  List<Map<String, String>> filteredRecommendedWorkshops = [];

  // STATE BARU: List untuk opsi dropdown
  final List<String> _locationOptions = [
    'New York',
    'Jakarta',
    'Bandung',
    'Surabaya',
  ];
  // STATE BARU: Lokasi yang saat ini dipilih
  String _currentSelectedLocation =
      'New York'; // Inisialisasi dengan nilai default "New York"

  // Controller untuk TextField pencarian
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredNearbyWorkshops = allNearbyWorkshops;
    filteredRecommendedProducts = allRecommendedProducts;
    filteredRecommendedWorkshops = allRecommendedWorkshops;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredNearbyWorkshops = allNearbyWorkshops.where((workshop) {
        return workshop['name']!.toLowerCase().contains(query);
      }).toList();

      filteredRecommendedProducts = allRecommendedProducts.where((product) {
        return product['name']!.toLowerCase().contains(query) ||
            product['shop']!.toLowerCase().contains(query);
      }).toList();

      filteredRecommendedWorkshops = allRecommendedWorkshops.where((workshop) {
        return workshop['name']!.toLowerCase().contains(query) ||
            workshop['location']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  // Widget untuk konten Halaman Home (yang asli)
  Widget _buildHomePageContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/google_logo.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Selamat Datang',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      'Yoga Pratama',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(Icons.bookmark_border, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Pemilih Lokasi: Teks Lokasi Saat Ini dan Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentSelectedLocation,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value:
                      _currentSelectedLocation, // Value dropdown harus sama dengan state
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF4A6B6B),
                  ),
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentSelectedLocation =
                          newValue!; // Update state saat dipilih
                      // Di sini kamu bisa menambahkan logika tambahan
                      // misalnya, memfilter data bengkel berdasarkan lokasi baru
                      _filterWorkshopsByLocation(newValue);
                    });
                  },
                  items: _locationOptions.map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Color(0xFF4A6B6B)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Search Bar (Kode ini sama)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by service name or product',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Bagian "Bengkel Terdekat" (Kode ini sama)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Bengkel Terdekat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredNearbyWorkshops.length,
              itemBuilder: (context, index) {
                final workshop = filteredNearbyWorkshops[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.asset(
                          workshop['image']!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workshop['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              workshop['distance']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),

          // Bagian "Rekomendasi Product" (Kode ini sama, dengan penyesuaian overflow)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Rekomendasi Product',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height:
                200, // Pertimbangkan untuk menyesuaikan tinggi ini jika masih overflow
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredRecommendedProducts.length,
              itemBuilder: (context, index) {
                final product = filteredRecommendedProducts[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              product['image']!,
                              height: 119,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ), // Coba atur ke 6.0 jika masih overflow
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1, // Tambahkan ini
                              overflow: TextOverflow.ellipsis, // Tambahkan ini
                            ),
                            const SizedBox(
                              height: 4,
                            ), // Coba atur ke 2.0 jika masih overflow
                            Text(
                              product['shop']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1, // Tambahkan ini
                              overflow: TextOverflow.ellipsis, // Tambahkan ini
                            ),
                            const SizedBox(
                              height: 4,
                            ), // Coba atur ke 2.0 jika masih overflow
                            Text(
                              product['price']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF4A6B6B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),

          // Bagian "Rekomendasi Bengkel" (Kode ini sama)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Rekomendasi Bengkel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 15),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: filteredRecommendedWorkshops.length,
            itemBuilder: (context, index) {
              final workshop = filteredRecommendedWorkshops[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          workshop['image']!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workshop['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 5),
                              Text(
                                workshop['location']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Logika ketika tombol "BOOK" ditekan
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A6B6B),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'BOOK',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Fungsi untuk memfilter bengkel berdasarkan lokasi
  void _filterWorkshopsByLocation(String? location) {
    if (location == null || location == 'New York') {
      // Default, tampilkan semua bengkel
      setState(() {
        filteredNearbyWorkshops = allNearbyWorkshops;
        filteredRecommendedWorkshops = allRecommendedWorkshops;
      });
    } else {
      setState(() {
        filteredNearbyWorkshops = allNearbyWorkshops.where((workshop) {
          // Asumsi 'distance' mengandung informasi lokasi, atau tambahkan kunci 'location'
          return workshop['distance']!.toLowerCase().contains(
            location.toLowerCase(),
          );
        }).toList();

        // Tambahkan filter untuk 'allRecommendedWorkshops' juga
        filteredRecommendedWorkshops = allRecommendedWorkshops.where((
          workshop,
        ) {
          return workshop['location']!.toLowerCase().contains(
            location.toLowerCase(),
          );
        }).toList();
      });
    }
    // Setelah filtering, mungkin juga perlu membersihkan search bar jika ada input
    _searchController.clear();
    _onSearchChanged(); // Untuk menerapkan kembali filter pencarian setelah filter lokasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5), // Light grey background
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomePageContent(), // Konten Halaman Home
          const ChatsPage(initialMessage: ''), // Halaman Chats
          const ProductPage(), // Halaman Products
          const ServicePage(), // Halaman Services
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build_outlined),
            activeIcon: Icon(Icons.build),
            label: 'Service',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4A6B6B),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }
}
