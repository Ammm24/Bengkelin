import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> productToCheckout;
  final Map<Map<String, dynamic>, int> selectedServices; // Tambahkan ini
  final double totalPrice; // Tambahkan ini

  const CheckoutPage({
    super.key,
    required this.productToCheckout,
    required this.selectedServices, // Jadikan required
    required this.totalPrice,
    required Map<String, dynamic> selectedService, // Jadikan required
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<Map<String, dynamic>> _addedItems = [];

  // Data dummy untuk servis tambahan (kartu-kartu yang bisa ditambahkan)
  final List<Map<String, dynamic>> additionalServices = [
    {
      'id': 'spion1',
      'name': 'Spion Mobil',
      'price': 'Rp 55.000',
      'image': 'assets/kaca_mobil.jpg',
    },
    {
      'id': 'spion2',
      'name': 'Spion Mobil',
      'price': 'Rp 55.000',
      'image': 'assets/kaca_mobil.jpg',
    },
    {
      'id': 'service_ac',
      'name': 'Servis A/C',
      'price': 'Rp 150.000',
      'image': 'assets/service_ac.jpg',
    },
    {
      'id': 'ban_motor',
      'name': 'Ban Motor',
      'price': 'Rp 250.000',
      'image': 'assets/ban_motor.jpg',
    },
    {
      'id': 'kampas_rem',
      'name': 'Kampas Rem',
      'price': 'Rp 80.000',
      'image': 'assets/kampas_rem.jpg',
    },
    {
      'id': 'busi',
      'name': 'Busi',
      'price': 'Rp 30.000',
      'image': 'assets/busi.jpg',
    },
  ];

  // Data dummy untuk pilihan bengkel (dari contoh sebelumnya)
  final List<Map<String, dynamic>> availableWorkshops = [
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
  ];

  // Untuk total perhitungan
  late double _totalPrice;
  final double _shippingFee = 5000.0;

  // Variabel untuk menyimpan pilihan metode pembayaran
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar item yang ditambahkan dengan produk utama
    _addedItems.add(widget.productToCheckout);

    // Tambahkan service yang dipilih dari ServiceCategoryPage ke _addedItems
    widget.selectedServices.forEach((service, quantity) {
      // Asumsi service memiliki 'name', 'price', dan 'image'
      // Anda mungkin perlu menyesuaikan ini jika struktur data service berbeda
      _addedItems.add({
        ...service, // Menyalin semua properti dari service
        'quantity': quantity, // Menambahkan kuantitas
      });
    });

    // Inisialisasi total harga dengan total harga yang diterima dari ServiceCategoryPage
    _totalPrice = widget.totalPrice;
  }

  // Helper untuk mengubah string harga menjadi double
  double _parsePrice(String priceString) {
    // Menghilangkan 'Rp ' dan '.' lalu mengubah ke double
    return double.parse(priceString.replaceAll('Rp ', '').replaceAll('.', ''));
  }

  // Metode untuk menambahkan item ke daftar _addedItems
  void _addItem(Map<String, dynamic> item) {
    setState(() {
      // Cek apakah item sudah ada di _addedItems
      bool itemFound = false;
      for (int i = 0; i < _addedItems.length; i++) {
        if (_addedItems[i]['id'] == item['id']) {
          // Jika item sudah ada, update kuantitas dan harga
          _addedItems[i]['quantity'] = (_addedItems[i]['quantity'] ?? 1) + 1;
          _totalPrice += _parsePrice(item['price']!);
          itemFound = true;
          break;
        }
      }
      if (!itemFound) {
        // Jika item belum ada, tambahkan item baru dengan kuantitas 1
        _addedItems.add({...item, 'quantity': 1});
        _totalPrice += _parsePrice(item['price']!);
      }
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${item['name']} ditambahkan!')));
  }

  // Metode untuk menghapus item dari daftar _addedItems
  void _deleteItem(int index) {
    setState(() {
      final item = _addedItems[index];
      final itemQuantity = item['quantity'] ?? 1;

      // Kurangi total harga berdasarkan kuantitas item yang dihapus
      _totalPrice -= _parsePrice(item['price']!) * itemQuantity;

      _addedItems.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Item dihapus!')));
  }

  // Fungsi untuk menampilkan modal pilihan pembayaran
  void _showPaymentMethodModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent, // Agar terlihat transparan di belakang sudut
      isScrollControlled: true, // <<< Tambahkan ini
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Gunakan StatefulBuilder untuk memperbarui state di dalam bottom sheet
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color(0xFFF0F1F5), // Warna latar belakang modal
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                // <<< Tambahkan ini
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),
                    const Text(
                      'Metode Pembayaran',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPaymentOption(
                      modalSetState,
                      'Gopay',
                      'assets/gopay_logo.png', // Ganti dengan path logo Gopay Anda
                      'Gopay',
                    ),
                    _buildPaymentOption(
                      modalSetState,
                      'Dana',
                      'assets/dana_logo.png', // Ganti dengan path logo Dana Anda
                      'Dana',
                    ),
                    _buildPaymentOption(
                      modalSetState,
                      'Mastercard',
                      'assets/mastercard_logo.png', // Ganti dengan path logo Mastercard Anda
                      'Mastercard',
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _selectedPaymentMethod == null
                            ? null // Nonaktifkan tombol jika belum ada pilihan
                            : () {
                                Navigator.pop(context); // Tutup modal
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Checkout dengan ${_selectedPaymentMethod!}',
                                    ),
                                  ),
                                );
                                // Lanjutkan ke proses checkout akhir
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F625D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Bayar Sekarang',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Widget pembangun opsi pembayaran individual
  Widget _buildPaymentOption(
    StateSetter modalSetState,
    String title,
    String imagePath,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          modalSetState(() {
            _selectedPaymentMethod = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: _selectedPaymentMethod == value
                  ? const Color(0xFF4F625D) // Warna border jika terpilih
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: _selectedPaymentMethod,
                onChanged: (String? newValue) {
                  modalSetState(() {
                    _selectedPaymentMethod = newValue;
                  });
                },
                activeColor: const Color(0xFF4F625D),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List Produk yang akan di-checkout (termasuk item tambahan)
            ListView.builder(
              shrinkWrap:
                  true, // Penting agar ListView tidak mengambil semua ruang
              physics:
                  const NeverScrollableScrollPhysics(), // Menonaktifkan scroll ListView
              itemCount: _addedItems.length,
              itemBuilder: (context, index) {
                final item = _addedItems[index];
                return _buildAddedItemCard(item, index);
              },
            ),
            const SizedBox(height: 20),

            // Title "Servis Tambahan"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Servis Tambahan',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Additional Services (Horizontal ListView)
            SizedBox(
              height: 200, // Tinggi tetap untuk ListView horizontal
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: additionalServices.length,
                itemBuilder: (context, index) {
                  final service = additionalServices[index];
                  return _buildServiceCard(service);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Title "Pilih Bengkel"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Pilih Bengkel',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Available Workshops (Horizontal ListView)
            SizedBox(
              height: 200, // Tinggi tetap untuk ListView horizontal
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: availableWorkshops.length,
                itemBuilder: (context, index) {
                  final workshop = availableWorkshops[index];
                  return _buildWorkshopCard(workshop);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Total Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Rp ${_totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}', // Format ke Rupiah
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping Fee',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Rp ${_shippingFee.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}', // Format ke Rupiah
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        Text(
                          'Rp ${(_totalPrice + _shippingFee).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}', // Format ke Rupiah
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Tombol Check Out Sekarang (di bagian bawah)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _showPaymentMethodModal(); // Panggil modal metode pembayaran
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F625D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Check Out Sekarang',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Spasi di bagian paling bawah
          ],
        ),
      ),
    );
  }

  // Widget baru untuk menampilkan item yang sudah ditambahkan (produk utama atau servis tambahan)
  Widget _buildAddedItemCard(Map<String, dynamic> item, int index) {
    // Menambahkan tampilan kuantitas
    final int quantity =
        item['quantity'] ?? 1; // Default 1 jika tidak ada kuantitas

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image']!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
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
                    item['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${item['price']} x $quantity', // Tampilkan harga dan kuantitas
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            // Tombol Delete
            SizedBox(
              width: 80,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  // Hanya izinkan penghapusan jika bukan produk utama
                  // Atau Anda bisa implementasi konfirmasi jika produk utama ingin dihapus
                  if (index != 0) {
                    // Jika bukan item pertama (produk utama)
                    _deleteItem(index);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Produk utama tidak bisa dihapus dari sini.',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F625D),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk kartu servis tambahan (yang ada tombol "Tambahkan")
  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                service['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
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
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  service['price']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Tombol "Tambahkan"
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      _addItem(
                        service,
                      ); // Panggil _addItem untuk menambahkan servis
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F625D),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Tambahkan',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk kartu bengkel (tidak berubah)
  Widget _buildWorkshopCard(Map<String, dynamic> workshop) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                workshop['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
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
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workshop['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  workshop['distance']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
