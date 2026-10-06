import 'dart:io';

void main() {
  // Daftar checkpoint patroli security
  List<String> checkpoints = [
    'Pos 1 - Gerbang Utama',
    'Pos 2 - Area Parkir',
    'Pos 3 - Gedung Utama',
    'Pos 4 - Gudang Belakang',
    'Pos 5 - Pintu Darurat',
  ];

  print('=== DAFTAR CHECKPOINT PATROLI SECURITY ===');
  for (int i = 0; i < checkpoints.length; i++) {
    print('${i + 1}. ${checkpoints[i]}');
  }

  // Jam mulai patroli & batas waktu per pos
  String jam = '08:00';
  int batasWaktu = 15;

  print('\nJam Mulai Patroli : $jam WIB');
  print('Batas Waktu per Pos: $batasWaktu menit');
  print('==========================================');

  // Konversi jam mulai ke total menit (misal 08:00 = 480 menit)
  int jamMulaiMenit = konversiKeMenit(jam);

  for (int i = 0; i < checkpoints.length; i++) {
    int iterasi = i + 1;

    // Formula: batas maksimal = nilai variable jam + (batas waktu * iterasi)
    int batasMaksimalMenit = jamMulaiMenit + (batasWaktu * iterasi);
    String batasMaksimalJam = formatMenitKeJam(batasMaksimalMenit);

    print('\n[Checkpoint $iterasi] ${checkpoints[i]}');
    print(
      'Target Maksimal : $batasMaksimalJam WIB (Maksimal +${batasWaktu * iterasi} menit)',
    );

    // 2. Input jam patroli untuk setiap checkpoint
    stdout.write('Masukkan jam tiba (contoh $batasMaksimalJam): ');
    String? input = stdin.readLineSync();

    // Nilai default jika input kosong
    if (input == null || input.trim().isEmpty) {
      input = batasMaksimalJam;
      print('-> Input kosong, otomatis menggunakan: $input');
    }

    int jamInputMenit = konversiKeMenit(input);

    // Jika user menginput hanya angka menit (contoh: 20 menit dari awal)
    if (!input.contains(':') && jamInputMenit < 60) {
      jamInputMenit = jamMulaiMenit + jamInputMenit;
    }

    // 3. Cek apakah jam yang di-input lebih dari target batas waktu
    if (jamInputMenit > batasMaksimalMenit) {
      int selisih = jamInputMenit - batasMaksimalMenit;
      print(
        'Status: TERLAMBAT ($selisih menit melewati batas $batasMaksimalJam)',
      );
    } else {
      int lebihAwal = batasMaksimalMenit - jamInputMenit;
      if (lebihAwal > 0) {
        print('Status: TEPAT WAKTU ($lebihAwal menit lebih awal)');
      } else {
        print('Status: TEPAT WAKTU (Tepat pada batas waktu $batasMaksimalJam)');
      }
    }
  }

  print('\n=== PATROLI SELESAI ===');
}

// Fungsi konversi format "HH:mm" atau angka menit ke total menit
int konversiKeMenit(String waktuStr) {
  if (waktuStr.contains(':')) {
    var parts = waktuStr.replaceAll(RegExp(r'[^0-9:]'), '').split(':');
    int h = int.tryParse(parts[0]) ?? 0;
    int m = int.tryParse(parts[1]) ?? 0;
    return (h * 60) + m;
  }
  return int.tryParse(waktuStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}

// Fungsi konversi total menit ke format string "HH:mm"
String formatMenitKeJam(int totalMenit) {
  int h = (totalMenit ~/ 60) % 24;
  int m = totalMenit % 60;
  return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
}
