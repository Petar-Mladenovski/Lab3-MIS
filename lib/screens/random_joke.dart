import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class RandomJoke extends StatelessWidget {
  const RandomJoke({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: const Text(
          'Random Joke',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Joke>(
        future: ApiServices.getRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final joke = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), 
                  ),
                  elevation: 8,
                  color: Colors.deepPurple[50],
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       
                        Text(
                          joke.setup,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold, 
                            color: Colors.deepPurpleAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      
                        Text(
                          joke.punchline,
                          style: const TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic, 
                            color: Colors.deepPurpleAccent,
                          ),
                          textAlign: TextAlign.center, 
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
