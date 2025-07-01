import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/owner/add_service_page.dart';
import 'package:flutter_bengkelin/views/owner/chat_page.dart';
import 'package:flutter_bengkelin/views/owner/home_page_owner.dart';
// import 'package:flutter_bengkelin/views/owner/product_owner.dart'; // Hapus atau komentari ini jika tidak lagi digunakan
import 'package:flutter_bengkelin/views/owner/add_product_page.dart'; // Import halaman AddProductPage

class MainWrapperOwner extends StatefulWidget {
  const MainWrapperOwner({super.key});

  @override
  State<MainWrapperOwner> createState() => _MainWrapperOwnerState();
}

class _MainWrapperOwnerState extends State<MainWrapperOwner> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomePageOwner(onNavigateToTab: _onItemTapped),
      const ChatsOwnerPage(),
      const AddProductPage(), // Indeks 2 untuk Product (sesuai urutan di BottomNavigationBar)
      const AddServicePage(), // Indeks 3 untuk Service
    ];
  }

  void _onItemTapped(int index) {
    // Logika navigasi tetap sederhana, karena kita sudah menukar widget di _widgetOptions
    // Cukup update _selectedIndex
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), // Ikon untuk Product
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build), // Ikon untuk Service
            label: 'Service',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4F625D), // Warna item yang dipilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Penting jika item lebih dari 3
      ),
    );
  }
}
