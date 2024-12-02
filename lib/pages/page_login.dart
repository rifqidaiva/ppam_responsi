import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ppam_responsi/components/icon.dart';
import 'package:ppam_responsi/components/input.dart';
import 'package:ppam_responsi/components/text.dart';
import 'package:ppam_responsi/model/user.dart';
import 'package:ppam_responsi/pages/app/page_app.dart';
import 'package:ppam_responsi/pages/page_register.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masuk"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CIconHeader(icon: Icons.login_rounded),
              const CTextHeader(text: "Masuk Responsi"),
              const SizedBox(height: 16),
              const Text(
                "Silahkan masuk dengan menggunakan email dan password Anda untuk melanjutkan ke aplikasi.",
              ),
              const SizedBox(height: 16),
              CTextField(
                controller: _emailController,
                labelText: "Email",
                prefixIcon: Icons.email,
                obscureText: false,
              ),
              CTextField(
                controller: _passwordController,
                labelText: "Password",
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              FilledButton(
                child: const Text("Masuk"),
                onPressed: () {
                  var box = Hive.box<User>("user");

                  // cek apakah email dan password sudah terdaftar
                  if (box.values.any((element) =>
                      element.email == _emailController.text &&
                      element.password == _passwordController.text)) {
                    // jika sudah terdaftar, maka arahkan ke halaman utama
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageApp(),
                      ),
                    );
                  } else {
                    // jika belum terdaftar, maka tampilkan pesan error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email atau password salah."),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                child: const Text("Belum punya akun? Daftar"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageRegister(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
