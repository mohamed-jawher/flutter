import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Variables to track the selected answer for each question
  String selectedAnswer1 = '';
  String selectedAnswer2 = '';
  String selectedAnswer3 = '';

  // Correct answers for each question
  final String correctAnswer1 = 'Dart';
  final String correctAnswer2 = 'XML';
  final String correctAnswer3 = 'Flutter';

  // Method to calculate the score
  int calculateScore() {
    int score = 0;
    if (selectedAnswer1 == correctAnswer1) score++;
    if (selectedAnswer2 == correctAnswer2) score++;
    if (selectedAnswer3 == correctAnswer3) score++;
    return score;
  }

  // Method to check if the quiz is completed
  bool isQuizCompleted() {
    return selectedAnswer1.isNotEmpty &&
        selectedAnswer2.isNotEmpty &&
        selectedAnswer3.isNotEmpty;
  }

  // Method to show the result dialog
  void showResultDialog(BuildContext context) {
    int score = calculateScore();
    String emoji = score == 3 ? "🏆" : (score > 0 ? "👍" : "😞");
    StringBuffer responseMessage = StringBuffer("Your score is $score out of 3. $emoji\n\n");

    // Check each question and append the correct answer if needed
    if (selectedAnswer1 != correctAnswer1) {
      responseMessage.writeln("1. Correct answer: $correctAnswer1");
    }
    if (selectedAnswer2 != correctAnswer2) {
      responseMessage.writeln("2. Correct answer: $correctAnswer2");
    }
    if (selectedAnswer3 != correctAnswer3) {
      responseMessage.writeln("3. Correct answer: $correctAnswer3");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completed!"),
        content: Text(responseMessage.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Method to display each question and its options
  Widget buildQuestion(
      String questionText, List<String> options, String selectedAnswer, String correctAnswer, int questionNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: options
              .map((option) => _buildOptionButton(option, selectedAnswer, correctAnswer, questionNumber))
              .toList(),
        ),
        SizedBox(height: 30), // Space between questions
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 83, 143),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 175, 211),
        title: Center(
          child: Text('Quiz ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // First question
            buildQuestion(
              '1. What programming language is used to develop Flutter apps?',
              ['Java', 'C++', 'Dart'],
              selectedAnswer1,
              correctAnswer1,
              1,
            ),

            // Second question
            buildQuestion(
              '2. What markup language is commonly used for Android layouts?',
              ['HTML', 'XML', 'JSON'],
              selectedAnswer2,
              correctAnswer2,
              2,
            ),

            // Third question
            buildQuestion(
              '3. Which framework is used for cross-platform app development by Google?',
              ['React Native', 'Flutter', 'Xamarin'],
              selectedAnswer3,
              correctAnswer3,
              3,
            ),
          ],
        ),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 72, 50, 150),
        onPressed: () {
          if (isQuizCompleted()) {
            showResultDialog(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please answer all the questions!")),
            );
          }
        },
        child: Icon(Icons.navigate_next, size: 28, color: Colors.white),
      ),
    );
  }

  // Method to build option buttons for questions
  Widget _buildOptionButton(String text, String selectedAnswer, String correctAnswer, int questionNumber) {
    Color buttonColor = Color.fromARGB(255, 71, 47, 207); // Default button color

    // Disable other options if one is selected
    bool isSelected = selectedAnswer.isNotEmpty;
    bool isCorrect = selectedAnswer == correctAnswer;
    if (isSelected) {
      buttonColor = (text == selectedAnswer)
          ? (isCorrect ? Color.fromARGB(255, 8, 230, 15) : Colors.red)
          : Colors.grey; // Disable other options
    }

    return ElevatedButton(
      onPressed: isSelected
          ? null
          : () {
              setState(() {
                if (questionNumber == 1) {
                  selectedAnswer1 = text;
                } else if (questionNumber == 2) {
                  selectedAnswer2 = text;
                } else if (questionNumber == 3) {
                  selectedAnswer3 = text;
                }
              });
            },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
