import 'package:basecode/components/my_button.dart';
import 'package:basecode/components/my_textfield.dart';
import 'package:basecode/components/square_tile.dart';
import 'package:basecode/services/auth/repository/auth_repository.dart';
import 'package:basecode/services/auth/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    context.read<AuthRepository>().loginUser(
          emailController.text,
          passwordController.text,
          context,
        );
  }

  void loginWithGoogle() async {
    context.read<AuthRepository>().signInWithGoogle(context);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Log In",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                  const Text(
                    "Log In to continue using the app",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: Color(0xFFB8B9C2),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    controller: emailController,
                    obscureText: false,
                    hint: "Enter your email here",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    controller: passwordController,
                    obscureText: true,
                    hint: "Enter your password here",
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  MyButton(
                    text: "Log in",
                    onTap: login,
                    color: Color(0xFF0265FF),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Color(0xFFB8B9C2),
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          " Register",
                          style: TextStyle(
                            color: Color(0xFF0265FF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or login with',
                            style: TextStyle(color: Color(0xFFB8B9C2)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: 'assets/google.png',
                        onTap: loginWithGoogle,
                      ),
                      SizedBox(width: 25),
                      SquareTile(
                        imagePath: 'assets/apple.png',
                        onTap: () {},
                      ),
                      SizedBox(width: 25),
                      SquareTile(
                        imagePath: 'assets/facebook.png',
                        onTap: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}