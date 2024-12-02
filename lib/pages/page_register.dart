import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ppam_responsi/components/icon.dart';
import 'package:ppam_responsi/components/input.dart';
import 'package:ppam_responsi/components/text.dart';
import 'package:ppam_responsi/model/user.dart';
import 'package:ppam_responsi/pages/page_login.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isPasswordMatch() {
    return _passwordController.text == _passwordConfirmController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CIconHeader(icon: Icons.app_registration_rounded),
              const CTextHeader(text: "Daftar Responsi"),
              const SizedBox(height: 16),
              const Text(
                "Silahkan daftar dengan menggunakan email dan password Anda untuk melanjutkan ke aplikasi.",
              ),
              const SizedBox(height: 16),
              CTextField(
                controller: _emailController,
                labelText: "Email",
                prefixIcon: Icons.email,
                obscureText: false,
              ),
              CTextField(
                controller: _nameController,
                labelText: "Nama",
                prefixIcon: Icons.person,
                obscureText: false,
              ),
              CTextField(
                controller: _passwordController,
                labelText: "Password",
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              CTextField(
                controller: _passwordConfirmController,
                labelText: "Konfirmasi Password",
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              FilledButton(
                child: const Text("Daftar"),
                onPressed: () async {
                  // Check if password match
                  if (!_isPasswordMatch()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("password tidak sama"),
                      ),
                    );
                    return;
                  }

                  // Check if email already registered
                  var box = await Hive.openBox('user');
                  if (box.containsKey(_emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email sudah terdaftar"),
                      ),
                    );
                    return;
                  }

                  await box.put(
                    _emailController.text,
                    User(
                      email: _emailController.text,
                      name: _nameController.text,
                      password: _passwordController.text,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Registrasi berhasil"),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageLogin(),
                    ),
                  );

                  box.close();
                },
              ),
              TextButton(
                child: const Text("Sudah punya akun? Masuk"),
                onPressed: () {
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
      ),
    );
  }
}
