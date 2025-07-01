// lib/views/owner/chats_owner.dart
import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/owner/chat_detail.dart'; // Import halaman percakapan baru

class ChatsOwnerPage extends StatelessWidget {
  const ChatsOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Latar belakang abu-abu muda
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Tambahkan ini agar "Chats" rata kiri
          children: [
            // Tambahkan padding di sini untuk mengganti tinggi AppBar
            const SizedBox(
              height: 50,
            ), // Sesuaikan tinggi sesuai kebutuhan desain Anda
            // Judul "Chats" manual, menggantikan judul AppBar
            const Text(
              'Chats',
              style: TextStyle(
                color: Color(0xFF1A1A2E), // Warna judul gelap
                fontWeight: FontWeight.bold,
                fontSize: 28, // Ukuran font lebih besar
              ),
            ),
            const SizedBox(height: 20), // Jarak antara judul dan search bar
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  30,
                ), // Radius lebih melingkar
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Pergeseran shadow
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name or skills',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none, // Hilangkan border bawaan TextField
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Daftar Chat
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero, // Hilangkan padding default ListView
                children: const [
                  ChatListItem(
                    avatarPath:
                        'assets/chatbot.jpg', // Ganti dengan path gambar chatbot Anda
                    name: 'Chat Bot',
                    lastMessage: 'We can do that on...',
                    unreadCount: 3,
                    time: '09:22',
                  ),
                  ChatListItem(
                    avatarPath:
                        'assets/profile1.png', // Ganti dengan path gambar Irene
                    name: 'Irene',
                    lastMessage: 'Pak apakah ini masih ter..',
                    unreadCount: 3,
                    time: '09:22',
                  ),
                  ChatListItem(
                    avatarPath:
                        'assets/profile2.png', // Ganti dengan path gambar Fulan
                    name: 'Fulan',
                    lastMessage: 'Buka jam berapa pak',
                    unreadCount: 2,
                    time: '09:22',
                  ),
                  // Tambahkan ChatListItem lainnya sesuai kebutuhan
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk setiap item chat
class ChatListItem extends StatelessWidget {
  final String avatarPath;
  final String name;
  final String lastMessage;
  final int unreadCount;
  final String time;

  const ChatListItem({
    super.key,
    required this.avatarPath,
    required this.name,
    required this.lastMessage,
    required this.unreadCount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15), // Jarak antar item
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Radius border Card
      ),
      elevation: 0, // Tanpa shadow untuk tampilan bersih
      color: Colors.white, // Warna latar belakang Card
      child: InkWell(
        // Untuk efek ripple saat diklik
        onTap: () {
          // Navigasi ke halaman ChatConversationPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatConversationPage(
                userName:
                    name, // Meneruskan nama lawan bicara ke halaman detail
                userAvatarPath:
                    avatarPath, // <-- Tambahkan ini untuk meneruskan path avatar
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25, // Ukuran avatar
                backgroundColor: Colors.grey[200], // Background fallback
                backgroundImage: AssetImage(avatarPath), // Gambar avatar
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle error jika gambar tidak ditemukan
                  debugPrint('Error loading image: $avatarPath');
                },
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A1A2E), // Warna teks nama
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lastMessage,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600], // Warna teks pesan
                      ),
                      maxLines: 1, // Pesan satu baris
                      overflow: TextOverflow
                          .ellipsis, // Tambahkan elipsis jika terlalu panjang
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500], // Warna teks waktu
                    ),
                  ),
                  if (unreadCount > 0) ...[
                    // Tampilkan badge jika ada pesan belum terbaca
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F625D), // Warna badge
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
