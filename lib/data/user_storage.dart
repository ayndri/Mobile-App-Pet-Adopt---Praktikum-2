import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String _kNama = 'user_nama';
  static const String _kNbi = 'user_nbi';
  static const String _kEmail = 'user_email';
  static const String _kAlamat = 'user_alamat';
  static const String _kInstagram = 'user_instagram';

  static Future<void> simpan({
    required String nama,
    required String nbi,
    required String email,
    required String alamat,
    required String instagram,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kNama, nama);
    await prefs.setString(_kNbi, nbi);
    await prefs.setString(_kEmail, email);
    await prefs.setString(_kAlamat, alamat);
    await prefs.setString(_kInstagram, instagram);
  }

  static Future<Map<String, String>> ambil() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'nama': prefs.getString(_kNama) ?? '',
      'nbi': prefs.getString(_kNbi) ?? '',
      'email': prefs.getString(_kEmail) ?? '',
      'alamat': prefs.getString(_kAlamat) ?? '',
      'instagram': prefs.getString(_kInstagram) ?? '',
    };
  }

  static Future<bool> sudahDaftar() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(_kNama) ?? '').isNotEmpty;
  }

  static Future<void> hapus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kNama);
    await prefs.remove(_kNbi);
    await prefs.remove(_kEmail);
    await prefs.remove(_kAlamat);
    await prefs.remove(_kInstagram);
  }
}
