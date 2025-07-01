// lib/views/owner/chat_conversation_page.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ChatConversationPage extends StatefulWidget {
  final String userName;
  final String
  userAvatarPath; // Tambahkan properti ini untuk menerima path avatar

  const ChatConversationPage({
    super.key,
    required this.userName,
    required this.userAvatarPath, // Pastikan ini juga required
  });

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final List<Map<String, dynamic>> _messages = [];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _messageController.clear();
      // TODO: Implement logic to send message to backend/service
    }
  }

  void _simulateBotResponse() {
    // Fungsi ini sekarang kosong karena kita tidak ingin simulasi pesan
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      PlatformFile file = result.files.single;
      debugPrint('Selected file: ${file.name}');
      debugPrint('File path: ${file.path}');

      // TODO: Di sini Anda akan mengimplementasikan logika untuk mengunggah file yang sebenarnya
    } else {
      debugPrint('File selection cancelled.');
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F625D),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            // Gambar avatar di samping nama
            CircleAvatar(
              radius: 18, // Sesuaikan ukuran avatar di AppBar
              backgroundImage: AssetImage(
                widget.userAvatarPath,
              ), // Menggunakan path avatar yang diterima
              backgroundColor: Colors.grey[300], // Fallback background
              onBackgroundImageError: (exception, stackTrace) {
                debugPrint(
                  'Error loading avatar image: ${widget.userAvatarPath}',
                );
              },
            ),
            const SizedBox(width: 8), // Jarak antara avatar dan nama
            Text(widget.userName), // Nama lawan bicara di AppBar
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender'] == 'user';
                return _buildMessageBubble(message['text'], isMe);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F625D),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _pickFile,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (text) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F625D),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFC7E5A5) : const Color(0xFF4F625D),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
