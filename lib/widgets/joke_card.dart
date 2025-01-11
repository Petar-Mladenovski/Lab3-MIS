import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const JokeCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5, 
      color: const Color.fromARGB(255, 234, 232, 245),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0), 
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Center( 
            child: Text(
              title[0].toUpperCase() + title.substring(1), 
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: const Color.fromARGB(255, 87, 46, 125), 
              ),
              textAlign: TextAlign.center, 
            ),
          ),
        ),
      ),
    );
  }
}
