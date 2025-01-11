import 'package:flutter/material.dart';
import '../models/joke.dart';

class JokeItem extends StatefulWidget {
  final Joke joke;
  final int index;

  const JokeItem({super.key, required this.joke, required this.index});

  @override
  _JokeItemState createState() => _JokeItemState();
}

class _JokeItemState extends State<JokeItem> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Joke #${widget.index + 1}'),
            content: Text(widget.joke.punchline),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.only(bottom: 20),
        color: Colors.deepPurple[50],
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Text(
                      '${widget.index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.joke.setup,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurpleAccent,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.joke.punchline,
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepPurpleAccent,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              child: IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? const Color.fromARGB(255, 158, 54, 244) : Colors.deepPurpleAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
