import 'package:flutter/material.dart';

import '../components/joke_container.dart';
import '../models/random_joke_model.dart';
import '../services/category_detail_service.dart';
import '../utils/custom_drawer.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  CategoryDetailScreenState createState() => CategoryDetailScreenState();
}

class CategoryDetailScreenState extends State<CategoryDetailScreen> {
  String firstJoke =
      "Hurricanes are mother nature's way of running from Chuck Norris";
  String imageUrl =
      'https://images01.military.com/sites/default/files/styles/full/public/2021-04/chucknorris.jpeg.jpg?itok=2b4A6n29';
  RandomJoke? data;
  List<RandomJoke> jokeList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchAllJokes();
  }

  Future<void> fetchAllJokes() async {
    for (int i = 0; i < 10; i++) {
      final joke = await getCategoryJoke(widget.category);
      jokeList.add(joke);
    }
    setState(() {
      data = jokeList[currentIndex];
    });
  }

  Future<void> handlePreviousJoke() async {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        data = jokeList[currentIndex];
      });
    } else {
      setState(() {
        currentIndex = jokeList.length - 1;
        data = jokeList[currentIndex];
      });
    }
  }

  Future<void> handleNextJoke() async {
    setState(() {
      currentIndex = (currentIndex + 1) % jokeList.length;
      data = jokeList[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
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
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  JokeContainer(data: data, firstJoke: firstJoke),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: handlePreviousJoke,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "Previous Joke",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: handleNextJoke,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "Next Joke",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
