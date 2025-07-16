// lib/main_wrapper_owner.dart
import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/owner/chat_page.dart';
import 'package:flutter_bengkelin/views/owner/home_page_owner.dart';
import 'package:flutter_bengkelin/views/owner/add_product_page.dart';
import 'package:flutter_bengkelin/views/owner/add_service_page.dart'; // Tambahkan import untuk AddServicePage

class MainWrapperOwner extends StatefulWidget {
  const MainWrapperOwner({super.key});

  @override
  State<MainWrapperOwner> createState() => _MainWrapperOwnerState();
}

class _MainWrapperOwnerState extends State<MainWrapperOwner> {
  int _selectedIndex = 0;
  // Ubah dari `late List<Widget> _widgetOptions;`
  // menjadi langsung diinisialisasi untuk mencegah LateInitializationError
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    // Pastikan _widgetOptions memiliki 4 elemen, sesuai dengan 4 item di BottomNavigationBar
    _widgetOptions = <Widget>[
      HomePageOwner(onNavigateToTab: _onItemTapped), // Indeks 0: Home
      const ChatsOwnerPage(), // Indeks 1: Chats
      const AddProductPage(), // Indeks 2: Product (sesuai permintaan sebelumnya mengarah ke AddProductPage)
      // Perhatikan: Jika Anda ingin Service mengarah ke AddServicePage,
      // maka ubah ServiceOwnerPage menjadi AddServicePage.
      // Jika ServiceOwnerPage tetap ada dan AddServicePage hanya dipanggil dari sana,
      // maka ServiceOwnerPage tetap benar di sini.
      // Saya asumsikan Anda ingin tombol "Service" di Bottom Nav langsung ke AddServicePage.
      const AddServicePage(), // Indeks 3: Service (mengarah ke AddServicePage)
    ];
  }

  void _onItemTapped(int index) {
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
        selectedItemColor: const Color(0xFF4F625D),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
