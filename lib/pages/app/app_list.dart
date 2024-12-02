import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ppam_responsi/instances/api.dart';
import 'package:ppam_responsi/model/user.dart';

class AppList extends StatefulWidget {
  final String email;

  const AppList({
    super.key,
    required this.email,
  });

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  String name = "";
  String password = "";
  List<int> favorite = [];
  List<ApiData> cratesData = [];

  @override
  void initState() {
    super.initState();
    API().getCrates().then((value) {
      setState(() {
        cratesData = value;
      });
    });

    // ambil data user dari hive
    _getUserData();
  }

  void _getUserData() async {
    var box = await Hive.openBox('user');
    var user = box.get(widget.email);

    if (user != null) {
      setState(() {
        name = user.name ?? "";
        password = user.password ?? "";
        favorite = user.favorite ?? [];
      });
    }

    box.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List"),
      ),
      body: ListView.builder(
        itemCount: cratesData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cratesData[index].name ?? "-",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Image.network(
                    cratesData[index].image ?? "",
                  ),
                ),
              ],
            ),
            subtitle: Text(cratesData[index].description ?? "-"),
            trailing: Icon(
              Icons.favorite,
              color: favorite.contains(index) ? Colors.red : null,
            ),
            contentPadding: const EdgeInsets.all(16),
            onTap: () async {
              // tambahkan index ke hive favorite
              var box = await Hive.openBox('user');

              // periksa apakah sudah ada di favorite, jika sudah hapus dari favorite
              if (box.get(widget.email)?.favorite?.contains(index) ?? false) {
                box.put(
                  widget.email,
                  User(
                    email: widget.email,
                    password: password,
                    name: name,
                    favorite: box.get(widget.email)?.favorite..remove(index),
                  ),
                );
              } else {
                box.put(
                  widget.email,
                  User(
                    email: widget.email,
                    password: password,
                    name: name,
                    favorite: box.get(widget.email)?.favorite..add(index),
                  ),
                );
              }

              setState(() {
                favorite = box.get(widget.email)?.favorite ?? [];
              });

              box.close();
            },
          );
        },
      ),
    );
  }
}
