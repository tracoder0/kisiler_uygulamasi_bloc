import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/user_dao_repository.dart';

class InsertPageCubit extends Cubit<void> {
  InsertPageCubit() : super(0);
  var urepo = UserDaoRepository();
  Future<void> insertUser(String kisi_ad, String kisi_tel) async {
    await urepo.insertUser(kisi_ad, kisi_tel);
  }
}
