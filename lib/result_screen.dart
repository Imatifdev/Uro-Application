import 'package:flutter/material.dart';
class ResultScreen extends StatefulWidget {
  final List answers;
  const ResultScreen({super.key, required this.answers});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Show the progress indicator for 3 seconds using Future.delayed
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(child: 
      SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Result", style: TextStyle(color: Colors.white, fontSize: 18),),
            isLoading
                  ? const CircularProgressIndicator(color: Colors.white,) // Show the progress indicator
                  : Text(widget.answers.toString(), style: const TextStyle(color: Colors.white)),
            ],
        ),
       )
      ),
    );
  }
}