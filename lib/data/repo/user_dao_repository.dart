import 'package:kisiler_uygulamasi/data/entities/user.dart';

class UserDaoRepository {
  Future<void> insertUser(String kisi_ad, String kisi_tel) async {
    print("Kişi adı $kisi_ad, kişi telefonu $kisi_tel");
  }

  Future<void> updateUser(int kisi_id, String kisi_ad, String kisi_tel) async {
    print("$kisi_id'li Kişi adı $kisi_ad, kişi telefonu $kisi_tel");
  }

  Future<List<User>> ara(String aramaKelimesi) async {
    var users = await getUsers();
    print(users);
    return users
        .where((element) =>
            element.user_ad.toLowerCase().contains("$aramaKelimesi"))
        .toList();
  }

  Future<List<User>> userDelete(int userID) async {
    var users = await getUsers();
    users.removeWhere((element) => element.user_id == userID);
    return users;
  }

  Future<List<User>> getUsers() async {
    var users = <User>[];
    users.add(User(user_id: 1, user_ad: "Cihat", user_tel: "123455"));
    users.add(User(user_id: 2, user_ad: "Demet", user_tel: "2585222"));
    users.add(User(user_id: 3, user_ad: "Ömer", user_tel: "6666666"));
    users.add(User(user_id: 4, user_ad: "Meryem", user_tel: "7777777"));
    return users;
  }
}
