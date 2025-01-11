import 'package:flutter/material.dart';
import '../services/api_services.dart';
import 'joke_by_type.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = ApiServices.getJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.casino, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, '/randomJoke');
            },
            tooltip: 'Get Random Joke',
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border_sharp, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, '/favPage');
            },
            tooltip: 'Get favourite page',
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No joke types available.'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  jokeTypes = ApiServices.getJokeTypes();  
                });
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final type = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokesByType(type: type),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: Colors.deepPurple[50],
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 30,
                              color: Colors.deepPurpleAccent,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                type,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
