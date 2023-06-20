import 'package:flutter/material.dart';
import '../models/random_joke_model.dart';

class JokeContainer extends StatelessWidget {
  final String firstJoke =
      "Hurricanes are mother nature's way of running from Chuck Norris";
  final RandomJoke? data;

  const JokeContainer({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 200,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: data != null
          ? _buildJokeTile(data!.value)
          : _buildJokeTile(firstJoke),
    );
  }

  Widget _buildJokeTile(String jokeText) {
    return ListTile(
      title: Text(
        jokeText,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
        softWrap: true,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
