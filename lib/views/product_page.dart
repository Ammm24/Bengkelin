import 'package:flutter/material.dart';
import 'package:flutter_bengkelin/views/product_detail_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _searchController = TextEditingController();

  // Data dummy untuk produk (DIPERBARUI DENGAN DESKRIPSI)
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Oil Motor MPX2',
      'shop': 'Bengkel Pak Jamil',
      'price': 'Rp 55.000',
      'image': 'assets/oli.jpg',
      'description':
          'AHM Oil MPX2 (Maximum Protection Expert) adalah oli mesin motor matic yang diformulasikan khusus untuk memberikan perlindungan maksimal pada mesin.',
    },
    {
      'name': 'Spion Mobil Xenia',
      'shop': 'Bengkel Pak Jamil',
      'price': 'Rp 1.495.000',
      'image': 'assets/kaca_mobil.jpg',
      'description':
          'Spion mobil berkualitas tinggi untuk Daihatsu Xenia, memberikan visibilitas optimal dan desain stylish. Cocok untuk penggantian atau upgrade.',
    },
    {
      'name': 'Ban Motor Michelin',
      'shop': 'Toko Ban Abadi',
      'price': 'Rp 350.000',
      'image': 'assets/ban_motor.jpg',
      'description':
          'Ban motor Michelin dengan performa superior, daya cengkeram kuat, dan awet. Ideal untuk berbagai kondisi jalan dan gaya berkendara.',
    },
    {
      'name': 'Kampas Rem Depan',
      'shop': 'Bengkel Jaya Raya',
      'price': 'Rp 120.000',
      'image': 'assets/kampas_rem.jpg',
      'description':
          'Kampas rem depan berkualitas tinggi untuk pengereman yang responsif dan aman. Kompatibel dengan berbagai jenis motor.',
    },
    {
      'name': 'Busi Motor NGK',
      'shop': 'Toko Sparepart Cepat',
      'price': 'Rp 30.000',
      'image': 'assets/busi.jpg',
      'description':
          'Busi motor NGK standar, memastikan pembakaran sempurna dan performa mesin optimal. Ideal untuk penggantian rutin.',
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
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
      filteredProducts = allProducts.where((product) {
        return product['name']!.toLowerCase().contains(query) ||
            product['shop']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      appBar: AppBar(
        title: const Text(
          'Product',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or shop',
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
          const SizedBox(height: 16.0),

          // Product Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  // Wrap _buildProductCard with InkWell for onTap
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                            itemDetail: {},
                          ),
                        ),
                      );
                    },
                    child: _buildProductCard(product),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
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
          // Gambar Produk
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                product['image']!,
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Produk
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1A2E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Nama Toko/Bengkel (Menggunakan 'shop' sekarang)
                Text(
                  product['shop']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Harga
                Text(
                  product['price']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
