import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/joke_item.dart';
import '../models/joke.dart';
import '../services/api_services.dart';

class JokesByType extends StatelessWidget {
  final String type;

  const JokesByType({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text(
          '${type[0].toUpperCase() + type.substring(1)} Jokes',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28, 
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
      body: FutureBuilder<List<Joke>>(
        future: ApiServices.getJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jokes available.'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final joke = snapshot.data![index];
                return JokeItem(joke: joke, index: index); 
              },
            );
          }
        },
      ),
    );
  }
}
