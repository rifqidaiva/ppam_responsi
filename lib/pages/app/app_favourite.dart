import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ppam_responsi/instances/api.dart';

class AppFavourite extends StatefulWidget {
  final String email;

  const AppFavourite({
    super.key,
    required this.email,
  });

  @override
  State<AppFavourite> createState() => _AppFavouriteState();
}

class _AppFavouriteState extends State<AppFavourite> {
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
        title: const Text("Favorit"),
      ),
      body: ListView.builder(
        itemCount: cratesData.length,
        itemBuilder: (context, index) {
          if (favorite.contains(index)) {
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
                    child: Image.network(cratesData[index].image ?? ""),
                  ),
                ],
              ),
              subtitle: Text(cratesData[index].description ?? "-"),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
