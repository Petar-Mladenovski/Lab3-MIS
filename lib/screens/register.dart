import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';
import '../providers/joke_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
        centerTitle: true,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: const Color.fromARGB(255, 122, 76, 175)
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter Name",
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 122, 76, 175), width: 2.0),
                      ),
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 122, 76, 175)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter Email",
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 122, 76, 175), width: 2.0),
                      ),
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 122, 76, 175)),
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
                      labelText: "Password",
                      hintText: "Enter Password",
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 122, 76, 175), width: 2.0),
                      ),
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 122, 76, 175)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibility.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromARGB(255, 122, 76, 175),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      hintText: "Enter Phone",
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 122, 76, 175), width: 2.0),
                      ),
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 122, 76, 175)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                      },
                      child: const Text(
                        "Already have an account? Sign In!",
                        style: TextStyle(color: Color.fromARGB(255, 122, 76, 175)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.check_circle_outline_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthService().register(
                            emailController.text,
                            passwordController.text,
                            context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all inputs'),
                          ),
                        );
                      }
                    },
                    label: const Text('Register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 122, 76, 175), // Updated color
                      foregroundColor: Colors.white,
                    ),
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
