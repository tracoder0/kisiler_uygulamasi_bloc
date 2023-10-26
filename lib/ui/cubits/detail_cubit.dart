

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/user_dao_repository.dart';

class DetailCubit extends Cubit<void> {
  DetailCubit() : super(0);
  var urepo = UserDaoRepository();
  Future<void> updateUser(int kisiId, String kisiAd, String kisiTel) async {
    await urepo.updateUser(kisiId, kisiAd, kisiTel);
  }
}
