import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/dog.dart';
import 'dog_detail_page.dart';

class DogHomePage extends StatefulWidget {
  const DogHomePage({super.key});

  @override
  State<DogHomePage> createState() => _DogHomePageState();
}

class _DogHomePageState extends State<DogHomePage> {
  List<Dog> _dogs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  Future<void> _ambilData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final url = Uri.parse('https://dog.ceo/api/breeds/image/random/20');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> gambar = data['message'];

        final List<Dog> hasil = [];
        for (int i = 0; i < gambar.length; i++) {
          final urlGambar = gambar[i].toString();
          hasil.add(
            Dog(
              imageUrl: urlGambar,
              nama: _ambilNamaRas(urlGambar),
              id: 'DOG-${(i + 1).toString().padLeft(3, '0')}',
              umur: '${(i % 6) + 1} tahun',
              status: (i % 4 == 0) ? 'Diadopsi' : 'Tersedia',
            ),
          );
        }

        setState(() {
          _dogs = hasil;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Gagal memuat data (kode ${response.statusCode})';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Terjadi kesalahan: $e';
        _loading = false;
      });
    }
  }

  String _ambilNamaRas(String url) {
    try {
      final bagian = url.split('/');
      final indexBreeds = bagian.indexOf('breeds');
      if (indexBreeds != -1 && indexBreeds + 1 < bagian.length) {
        final slug = bagian[indexBreeds + 1];
        return slug
            .split('-')
            .map((kata) =>
                kata.isEmpty ? kata : kata[0].toUpperCase() + kata.substring(1))
            .join(' ');
      }
    } catch (_) {}
    return 'Anjing';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Adopt a Dog',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _ambilData,
            icon: const Icon(Icons.refresh, color: Color(0xFF1E3A8A)),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _ambilData,
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dogs.length,
      itemBuilder: (context, index) => _buildItem(_dogs[index]),
    );
  }

  void _bukaDetail(Dog dog) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DogDetailPage(dog: dog)),
    );
  }

  Widget _buildItem(Dog dog) {
    final bool tersedia = dog.status == 'Tersedia';

    return InkWell(
      onTap: () => _bukaDetail(dog),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(
                dog.imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const SizedBox(
                    width: 110,
                    height: 110,
                    child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 110,
                  height: 110,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dog.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${dog.id}',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.cake_outlined,
                            size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          dog.umur,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: tersedia
                            ? Colors.green.withOpacity(0.12)
                            : Colors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        dog.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: tersedia
                              ? Colors.green.shade700
                              : Colors.orange.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
