import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entities/user.dart';
import 'package:kisiler_uygulamasi/ui/cubits/detail_cubit.dart';

class Detail extends StatefulWidget {
  User user;
  Detail({required this.user});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var tfKisiId = TextEditingController();
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  void initState() {
    super.initState();
    var user = widget.user;
    tfKisiId.text = user.user_id.toString();
    tfKisiAdi.text = user.user_ad;
    tfKisiTel.text = user.user_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Detayı"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: const InputDecoration(hintText: "Kişi Adı"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: const InputDecoration(hintText: "Kişi Telefonu"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<DetailCubit>().updateUser(
                        widget.user.user_id, tfKisiAdi.text, tfKisiTel.text);
                  },
                  child: const Text("Güncelle"))
            ],
          ),
        ),
      ),
    );
  }
}
