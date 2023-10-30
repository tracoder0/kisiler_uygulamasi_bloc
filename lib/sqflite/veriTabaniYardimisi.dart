import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeriTabaniYardimisi {
  static const String veriTabaniAdi = "rehber.db";
  static Future<Database> veriTabaniErisim() async {
    String veriTabaniYolu = join(await getDatabasesPath(), veriTabaniAdi);
    if (await databaseExists(veriTabaniYolu)) {
      print("Veri Tabanı Mevcut, Kopyalamaya Gerek Yok");
    } else {
      ByteData data = await rootBundle.load("db/$veriTabaniAdi");
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(veriTabaniYolu).writeAsBytes(bytes, flush: true);
      print("Veri Tabanı Kopyalandı");
    }
    return openDatabase(veriTabaniYolu);
  }
}
