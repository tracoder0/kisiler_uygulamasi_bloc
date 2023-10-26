import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entities/user.dart';
import 'package:kisiler_uygulamasi/data/repo/user_dao_repository.dart';

class HomePageCubit extends Cubit<List<User>> {
  HomePageCubit() : super(<User>[]);
  var urepo = UserDaoRepository();

  Future<void> ara(String aramaKelimesi) async {
    var gUsers = await urepo.ara(aramaKelimesi);
    emit(gUsers);
  }

  Future<void> userDelete(int userID) async {
    var users = await urepo.userDelete(userID);
    emit(users);
  }

  Future<void> getUsers() async {
    var gusers = await urepo.getUsers();
    emit(gusers);
  }
}
