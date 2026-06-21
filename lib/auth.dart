import 'package:flutter/material.dart';

import 'services.dart';
import 'widgets.dart';
import 'welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> register() async {
    try {
      setState(() {
        loading = true;
      });

      final credential =
          await AuthService.register(
        email: emailController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      await FirestoreService.saveUser(
        uid: credential.user!.uid,
        name: nameController.text,
        email: emailController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            Image.asset(
              "assets/logo.jpg",
              height: 150,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: nameController,
              label: "Nama",
            ),

            const SizedBox(height: 15),

            CustomTextField(
              controller: emailController,
              label: "Email",
            ),

            const SizedBox(height: 15),

            CustomTextField(
              controller:
                  passwordController,
              label: "Password",
              obscure: true,
            ),

            const SizedBox(height: 20),

            loading
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: "Daftar",
                    onPressed: register,
                  ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginPage(),
                  ),
                );
              },
              child: const Text(
                "Sudah punya akun? Login",
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> login() async {
    try {

      setState(() {
        loading = true;
      });

      await AuthService.login(
        email: emailController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      await SessionService.saveLogin();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const WelcomePage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Login")),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            Image.asset(
              "assets/logo.jpg",
              height: 150,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: emailController,
              label: "Email",
            ),

            const SizedBox(height: 15),

            CustomTextField(
              controller:
                  passwordController,
              label: "Password",
              obscure: true,
            ),

            Align(
              alignment:
                  Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ForgotPasswordPage(),
                    ),
                  );
                },
                child: const Text(
                  "Forgot Password?",
                ),
              ),
            ),

            loading
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: "Login",
                    onPressed: login,
                  ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordPage
    extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage>
      createState() =>
          _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {

  final emailController =
      TextEditingController();

  Future<void> resetPassword() async {
    try {

      await AuthService.resetPassword(
        emailController.text.trim(),
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Email reset password terkirim",
          ),
        ),
      );
    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Forgot Password"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            CustomTextField(
              controller: emailController,
              label: "Email",
            ),

            const SizedBox(height: 20),

            CustomButton(
              text: "Send to Email",
              onPressed: resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}