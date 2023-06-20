import 'package:flutter/material.dart';

import '../components/joke_container.dart';
import '../models/random_joke_model.dart';
import '../services/random_joke_service.dart';
import '../utils/custom_drawer.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  RandomJokeScreenState createState() => RandomJokeScreenState();
}

class RandomJokeScreenState extends State<RandomJokeScreen> {
  String firstJoke =
      "Hurricanes are mother nature's way of running from Chuck Norris";
  String imageUrl =
      'https://images01.military.com/sites/default/files/styles/full/public/2021-04/chucknorris.jpeg.jpg?itok=2b4A6n29';
  RandomJoke? data;

  Future<void> handleGetRandomJoke() async {
    final response = await getRandomJoke();
    setState(() => data = response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          if (imageUrl.isNotEmpty)
            Opacity(
              opacity: 0.9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  JokeContainer(data: data, firstJoke: firstJoke),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleGetRandomJoke,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      "New Joke!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
