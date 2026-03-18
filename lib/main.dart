import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final random = Random();

  // 100 motivational quotes
  final List<String> quotes = [
    "Believe in yourself.",
    "Every day is a fresh start.",
    "You are stronger than you think.",
    "Progress, not perfection.",
    "Dream big. Start small. Act now.",
    "Discipline beats motivation.",
    "Stay consistent.",
    "Your only limit is you.",
    "Small steps lead to big results.",
    "Focus on the goal.",
    "Don’t quit.",
    "Make it happen.",
    "Success starts with self-belief.",
    "Hard work pays off.",
    "Stay hungry. Stay foolish.",
    "Be better than yesterday.",
    "Turn pain into power.",
    "Push through the struggle.",
    "You’ve got this.",
    "Keep going.",
    "Doubt kills more dreams than failure ever will.",
    "Start now.",
    "Be fearless.",
    "Action creates confidence.",
    "Mistakes are proof you are trying.",
    "Consistency is key.",
    "Work in silence.",
    "Let results speak.",
    "Stay positive.",
    "Chase your dreams.",
    "Do it for your future self.",
    "Wake up and grind.",
    "Focus. Learn. Improve.",
    "Your mindset matters.",
    "Think big.",
    "Stay humble. Work hard.",
    "Never settle.",
    "Make today count.",
    "Be unstoppable.",
    "Choose growth.",
    "Be brave.",
    "Success takes time.",
    "Don’t compare yourself to others.",
    "Trust the process.",
    "Stay patient.",
    "Keep learning.",
    "Fall seven times, stand up eight.",
    "Energy flows where focus goes.",
    "Be disciplined.",
    "Take responsibility.",
    "Build good habits.",
    "One day or day one. You decide.",
    "Stay focused.",
    "Be proud of your progress.",
    "Strive for progress.",
    "Win the day.",
    "Push your limits.",
    "Embrace the challenge.",
    "Your future needs you.",
    "Don’t stop until you’re proud.",
    "Be the change.",
    "Do something today your future self will thank you for.",
    "Stay committed.",
    "Keep pushing.",
    "Learn from failure.",
    "Act with purpose.",
    "Stay strong.",
    "Make yourself proud.",
    "Fear is temporary. Regret is forever.",
    "Great things take time.",
    "Stay motivated.",
    "You are capable.",
    "Create your own path.",
    "Keep improving.",
    "Success is earned.",
    "Turn dreams into plans.",
    "Be relentless.",
    "Focus on solutions.",
    "Every effort counts.",
    "Stay determined.",
    "Rise and shine.",
    "Be confident.",
    "You control your destiny.",
    "Keep building.",
    "Stay sharp.",
    "Stay inspired.",
    "Don’t look back.",
    "Stay disciplined.",
    "Keep moving forward.",
    "Do it with passion.",
    "Be intentional.",
    "Stay resilient.",
    "Own your journey.",
    "Keep striving.",
    "Win your mind.",
    "Your effort matters.",
    "Be extraordinary.",
    "Success is a mindset."
  ];

  String currentQuote = "Press the button to get motivated!";
  final List<String> favorites = [];

  // Button color
  Color _buttonColor = Colors.blue;

  // Background color
  Color _backgroundColor = Colors.blue.shade100;
  final List<Color> _bgColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.yellow.shade100,
  ];
  int _bgColorIndex = 0;

  // Generate new quote
  void changeText() {
    setState(() {
      currentQuote = quotes[random.nextInt(quotes.length)];
    });
  }

  // Like/unlike
  void toggleFavorite() {
    setState(() {
      if (favorites.contains(currentQuote)) {
        favorites.remove(currentQuote);
      } else {
        favorites.add(currentQuote);
      }
    });
  }

  // Share quote
  void shareQuote() {
    Share.share(currentQuote);
  }

  // Change background color
  void changeBackgroundColor() {
    setState(() {
      _bgColorIndex = (_bgColorIndex + 1) % _bgColors.length;
      _backgroundColor = _bgColors[_bgColorIndex];
    });
  }

  // Pick button color (5 choices)
  Future<void> _showColorPickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose a button color'),
        content: Wrap(
          spacing: 10,
          children: [
            _buildColorOption(Colors.red),
            _buildColorOption(Colors.blue),
            _buildColorOption(Colors.green),
            _buildColorOption(Colors.orange),
            _buildColorOption(Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _buttonColor = color;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _buttonColor == color
                ? Colors.black
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text("Daily Motivation"),
        backgroundColor: Colors.blue.shade400,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(favorites: favorites),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentQuote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 15,
                children: [
                  ElevatedButton(
                    onPressed: changeText,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor,
                    ),
                    child: const Text("Get Motivation"),
                  ),
                  ElevatedButton(
                    onPressed: toggleFavorite,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: favorites.contains(currentQuote)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    child: const Text("Like"),
                  ),
                  ElevatedButton(
                    onPressed: shareQuote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor,
                    ),
                    child: const Text("Share"),
                  ),
                  ElevatedButton(
                    onPressed: changeBackgroundColor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor,
                    ),
                    child: const Text("Change BG"),
                  ),
                  ElevatedButton(
                    onPressed: _showColorPickerDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor,
                    ),
                    child: const Text("Pick Button Color"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Favorites Screen
class FavoritesScreen extends StatelessWidget {
  final List<String> favorites;
  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favorites[index]),
                );
              },
            ),
    );
  }
}
