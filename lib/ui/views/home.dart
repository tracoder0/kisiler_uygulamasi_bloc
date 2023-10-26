import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entities/user.dart';
import 'package:kisiler_uygulamasi/ui/cubits/home_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/detail.dart';
import 'package:kisiler_uygulamasi/ui/views/insertpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool aramaYapiliyorMu = false;
  var tfSearch = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomePageCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: aramaYapiliyorMu
              ? TextField(
                  controller: tfSearch,
                  decoration: const InputDecoration(hintText: "Arama"),
                  onChanged: (src) {
                    context.read<HomePageCubit>().ara(src);
                  },
                )
              : const Text("Kişiler"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    aramaYapiliyorMu = !aramaYapiliyorMu;
                  });
                  context.read<HomePageCubit>().getUsers();
                  tfSearch.text = "";
                },
                icon: aramaYapiliyorMu
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.search))
          ],
        ),
        body: BlocBuilder<HomePageCubit, List<User>>(
          builder: (context, getusers) {
            if (getusers.isNotEmpty) {
              return ListView.builder(
                itemCount: getusers.length,
                itemBuilder: (context, index) {
                  var us = getusers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail(user: us)))
                          .then((value) => null);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          height: 60,
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    us.user_ad,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(us.user_tel)
                                ],
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "${us.user_ad} isimli kişi silinsin mi?"),
                                  action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        context
                                            .read<HomePageCubit>()
                                            .userDelete(us.user_id);                                        
                                      }),
                                ));
                              },
                              icon: const Icon(Icons.remove_circle),
                              color: Colors.red,
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Kişi Bulunamadı"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const InsertPage()))
                .then((value) {
              print("Ana Sayfaya Dönüldü");
            });
          },
          child: const Icon(Icons.add_card),
        ));
  }
}
