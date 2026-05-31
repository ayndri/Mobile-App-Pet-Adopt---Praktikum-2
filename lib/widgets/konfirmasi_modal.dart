import 'package:flutter/material.dart';

class KonfirmasiModal extends StatelessWidget {
  final Map<String, String> pet;
  final String kategori;
  final BuildContext pageContext;

  const KonfirmasiModal({
    Key? key,
    required this.pet,
    required this.kategori,
    required this.pageContext,
  }) : super(key: key);

  void _onKonfirmasi(BuildContext modalContext) {
    Navigator.pop(modalContext);
    showDialog(
      context: pageContext,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.calendar_month, color: Color(0xFF1E3A8A)),
            SizedBox(width: 8),
            Text('Jadwalkan Kunjungan?'),
          ],
        ),
        content: Text(
          'Apakah kamu ingin menjadwalkan kunjungan untuk mengambil ${pet['nama']}?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(pageContext);
              ScaffoldMessenger.of(pageContext).showSnackBar(
                SnackBar(
                  content: Text('Berhasil mengadopsi ${pet['nama']}! 🎉'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Tidak', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(pageContext);
              final picked = await showDatePicker(
                context: pageContext,
                initialDate: DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                helpText: 'Pilih Tanggal Kunjungan',
              );
              if (picked != null) {
                final tgl =
                    '${picked.day}/${picked.month}/${picked.year}';
                ScaffoldMessenger.of(pageContext).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Kunjungan untuk ${pet['nama']} dijadwalkan $tgl 🗓️'),
                    backgroundColor: Colors.blue,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Ya', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Icon(Icons.pets, size: 64, color: Color(0xFF1E3A8A)),
          const SizedBox(height: 16),
          const Text(
            'Konfirmasi Adopsi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Apakah kamu yakin ingin mengadopsi hewan ini?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              children: [
                _detailRow('Nama Hewan', pet['nama']!),
                const Divider(height: 20),
                _detailRow('Jenis', pet['jenis']!),
                const Divider(height: 20),
                _detailRow('Kategori', kategori),
                const Divider(height: 20),
                _detailRow('Umur', pet['umur']!),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Batal',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _onKonfirmasi(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Konfirmasi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
