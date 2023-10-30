import 'package:kisiler_uygulamasi/data/entities/user.dart';
import 'package:kisiler_uygulamasi/sqflite/veriTabaniYardimisi.dart';

class UserDaoRepository {
  Future<void> insertUser(String kisi_ad, String kisi_tel) async {
    var db = await VeriTabaniYardimisi.veriTabaniErisim();
    var yeniKisi = Map<String, dynamic>();
    yeniKisi["kisi_ad"] = kisi_ad;
    yeniKisi["kisi_tel"] = kisi_tel;
    await db.insert("kisiler", yeniKisi);
  }

  Future<void> updateUser(int kisi_id, String kisi_ad, String kisi_tel) async {
    var db = await VeriTabaniYardimisi.veriTabaniErisim();
    var yeniKisi = Map<String, dynamic>();
    yeniKisi["kisi_ad"] = kisi_ad;
    yeniKisi["kisi_tel"] = kisi_tel;
    await db
        .update("kisiler", yeniKisi, where: "kisi_id=?", whereArgs: [kisi_id]);
  }

  Future<List<User>> ara(String aramaKelimesi) async {
    var db = await VeriTabaniYardimisi.veriTabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "select * from kisiler where kisi_ad like '%$aramaKelimesi%'");
    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return User(
          user_id: satir["kisi_id"],
          user_ad: satir["kisi_ad"],
          user_tel: satir["kisi_tel"]);
    });
  }

  Future<void> userDelete(int userID) async {
    var db = await VeriTabaniYardimisi.veriTabaniErisim();
    db.delete("kisiler", where: "kisi_id=?", whereArgs: [userID]);
  }

  Future<List<User>> getUsers() async {
    var db = await VeriTabaniYardimisi.veriTabaniErisim();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from kisiler");

    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return User(
          user_id: satir["kisi_id"],
          user_ad: satir["kisi_ad"],
          user_tel: satir["kisi_tel"]);
    });
  }
}
