import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction,
                size: 90,
                color: Colors.brown.shade300,
              ),
              const SizedBox(height: 20),  
              Text(
                '$title en construcción',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Próximamente Disponible',
                style: TextStyle(
                  color: Colors.grey.shade600, 
                ),
              ),
            ],  
          ),
        ), 
    );
  }
}