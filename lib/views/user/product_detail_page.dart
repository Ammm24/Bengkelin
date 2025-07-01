import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/user/checkout_page.dart';
import 'package:intl/intl.dart'; // Tambahkan untuk format mata uang

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  // Constructor awal Anda
  const ProductDetailPage({
    super.key,
    required this.product,
    required Map<String, dynamic>
    itemDetail, // Pertahankan ini seperti yang Anda inginkan
  });

  // Helper untuk mengurai harga dari string ke double
  double _parsePrice(String priceString) {
    String cleanPrice = priceString
        .replaceAll('Rp ', '')
        .replaceAll('.', '')
        .replaceAll(',', '');
    return double.tryParse(cleanPrice) ?? 0.0;
  }

  // Helper untuk format mata uang IDR
  String _formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    // Penanganan null dasar untuk properti product
    final String productName =
        product['name'] as String? ?? 'Produk Tidak Tersedia';
    final String productShop =
        product['shop'] as String? ?? 'Toko Tidak Tersedia';
    final String productPriceString = product['price'] as String? ?? 'Rp 0';
    final String productDescription =
        product['description'] as String? ??
        'Tidak ada deskripsi untuk produk ini.';
    final String productImage = product['image'] as String? ?? '';

    // Asumsi kuantitas selalu 1 dari ProductDetailPage ini jika tidak ada mekanisme kuantitas
    final int productQuantity = 1;
    final double productCalculatedPrice =
        _parsePrice(productPriceString) * productQuantity;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detail Product',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: productImage.isNotEmpty
                      ? Image.asset(
                          productImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 250,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : const SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Nama Produk, Toko, dan Harga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    productShop,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _formatCurrency(
                      _parsePrice(productPriceString),
                    ), // Format harga
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Deskripsi Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    productDescription,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Tombol "Check Out Sekarang"
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Siapkan data produk untuk CheckoutPage
                    final Map<String, dynamic> productDataForCheckout = {
                      'id': product['id'] ?? UniqueKey().toString(),
                      'name': productName,
                      'price': productPriceString,
                      'image': productImage,
                      'description': productDescription,
                      'quantity': productQuantity, // Kuantitas diasumsikan 1
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          productToCheckout: productDataForCheckout,
                          totalPrice: productCalculatedPrice,
                          selectedService:
                              productDataForCheckout, // Bisa juga kirim productDataForCheckout di sini
                          selectedServices:
                              null, // Ini harus null karena tidak ada servis kategori dari sini
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F625D),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Check Out Sekarang',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
