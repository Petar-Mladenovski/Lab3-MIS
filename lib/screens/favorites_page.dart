import 'package:flutter/material.dart';
import '../providers/joke_provider.dart';
import '../widgets/joke_item.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<JokeProvider>().jokes.where(
          (p) => p.isFavorite,
        ).toList(); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Joke Explorer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.heart_broken),
                  SizedBox(
                    height: 10,
                  ),
                  Text("You've no favorites yet."),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return JokeItem(
                  joke: favorites[index],
                  index: index, 
                );
              },
            ),
    );
  }
}
