import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ppam_responsi/components/profile.dart';
import 'package:ppam_responsi/components/text.dart';
import 'package:ppam_responsi/pages/page_login.dart';

class AppProfile extends StatefulWidget {
  final String email;

  const AppProfile({
    super.key,
    required this.email,
  });

  @override
  State<AppProfile> createState() => _AppProfileState();
}

class _AppProfileState extends State<AppProfile> {
  String name = "";
  String password = "";

  @override
  void initState() {
    super.initState();

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
      });
    }

    box.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Center(
        child: Column(
          children: [
            CProfileAvatar(
              text: name,
              radius: 40,
            ),
            const SizedBox(height: 10),
            CTextHeader(text: name),
            const SizedBox(height: 10),
            Text(
              widget.email,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: const Text("Keluar"),
              leading: const Icon(Icons.logout),
              visualDensity: VisualDensity.compact,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageLogin(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
