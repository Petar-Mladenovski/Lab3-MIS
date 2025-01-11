import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/joke_provider.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  getMail() async {
    return await AuthService().getEmail().then((value) {
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerProvider = Provider.of<JokeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Profile Page", style: TextStyle(fontSize: 24, color: Colors.deepPurpleAccent)),
        Stack(children: [
            imagePickerProvider.image == null
                ? const CircleAvatar(radius: 100, backgroundImage: NetworkImage("https://avatar.iran.liara.run/public"))
                : CircleAvatar(radius: 100, backgroundImage: FileImage(imagePickerProvider.image!)),
            Positioned(bottom: 10, right: 10,
              child: GestureDetector(
                onTap: () => imagePickerProvider.pickImage(),
                child: Container(padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 122, 76, 175), shape: BoxShape.circle),
                  child: const Icon(Icons.add_a_photo, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
        FutureBuilder(future: getMail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final String mail = snapshot.data as String;
              return emailCard(mail);
            }),
      ],
    );
  }

  Card emailCard(String email) {
    return Card(elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 28, color: Colors.deepPurpleAccent),
            const SizedBox(width: 10),
            Text(email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
