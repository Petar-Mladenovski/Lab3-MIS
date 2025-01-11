import 'package:flutter/material.dart';
import '../screens/register.dart';
import '../providers/joke_provider.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisibility = Provider.of<JokeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 122, 76, 175), // Changed color
        title: const Text("Login", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)), // Changed text color to white
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      hintText: "Enter Email",
                      labelStyle: TextStyle(color: Color.fromARGB(255, 122, 76, 175)), // Changed color
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 122, 76, 175)), // Changed color
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!isValidEmail(value)) {
                        return 'Email not valid!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: passwordVisibility.isObscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter Password",
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 122, 76, 175)), // Changed color
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 122, 76, 175)), // Changed color
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibility.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromARGB(255, 122, 76, 175), // Changed color
                        ),
                        onPressed: () {
                          passwordVisibility.toggleVisibility();
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password should not have less than 6 characters.';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Register!",
                        style: TextStyle(color: Color.fromARGB(255, 122, 76, 175)), // Changed color
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 122, 76, 175), // Changed color
                    ),
                    icon: const Icon(Icons.check_circle_outline_sharp,
                    color: Colors.white),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthService().login(
                          emailController.text,
                          passwordController.text,
                          context,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill input'),
                          ),
                        );
                      }
                    },
                    label: const Text('Submit',
                        style: TextStyle(
                          color: Colors.white
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
