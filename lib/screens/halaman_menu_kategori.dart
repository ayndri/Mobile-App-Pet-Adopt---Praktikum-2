import 'package:flutter/material.dart';
import 'page_list_pets.dart';

class HalamanMenuKategori extends StatelessWidget {
  const HalamanMenuKategori({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> _kategori = [
    {
      'title': 'Anjing',
      'emoji': '🐕',
      'color': Color(0xFF1E3A8A),
      'bgColor': Color(0xFFEFF6FF),
    },
    {
      'title': 'Kucing',
      'emoji': '🐱',
      'color': Color(0xFF0F766E),
      'bgColor': Color(0xFFF0FDFA),
    },
    {
      'title': 'Kelinci',
      'emoji': '🐰',
      'color': Color(0xFFEA580C),
      'bgColor': Color(0xFFFFF7ED),
    },
    {
      'title': 'Burung',
      'emoji': '🐦',
      'color': Color(0xFF7C3AED),
      'bgColor': Color(0xFFF5F3FF),
    },
    {
      'title': 'Hamster',
      'emoji': '🐹',
      'color': Color(0xFFB45309),
      'bgColor': Color(0xFFFEF3C7),
    },
    {
      'title': 'Ikan',
      'emoji': '🐟',
      'color': Color(0xFF0369A1),
      'bgColor': Color(0xFFE0F2FE),
    },
    {
      'title': 'Kura-kura',
      'emoji': '🐢',
      'color': Color(0xFF15803D),
      'bgColor': Color(0xFFF0FDF4),
    },
    {
      'title': 'Guinea Pig',
      'emoji': '🐾',
      'color': Color(0xFFBE185D),
      'bgColor': Color(0xFFFDF2F8),
    },
    {
      'title': 'Reptil',
      'emoji': '🦎',
      'color': Color(0xFF4D7C0F),
      'bgColor': Color(0xFFF7FEE7),
    },
    {
      'title': 'Landak Mini',
      'emoji': '🦔',
      'color': Color(0xFF9F1239),
      'bgColor': Color(0xFFFFF1F2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pet Adopt',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/pets.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pilih Kategori Hewan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: _kategori.length,
                itemBuilder: (context, index) {
                  final item = _kategori[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PageListPets(kategori: item['title']),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: item['bgColor'],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              item['emoji'],
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['title'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: item['color'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
