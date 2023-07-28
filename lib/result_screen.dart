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
      body: 
      !isLoading?
      SafeArea(child: 
      SizedBox(
        height: size.height-100,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Result", style: TextStyle(color: Colors.white, fontSize: 18),),              
              SizedBox(
                height: size.height/6,
                child: ListView.builder(
                  itemCount: widget.answers.length,
                  itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text("Question ${index+1}", style: const TextStyle(color: Colors.white),),
                    Text(widget.answers[index].toString(), style: const TextStyle(color: Colors.white)),
                   ],
                 ),),
              ),
            ],
          )
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     const Text("Result", style: TextStyle(color: Colors.white, fontSize: 18),),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 1", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[0].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 2", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[1].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 3", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[2].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 4", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[3].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 5", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[4].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 6", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[5].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //      Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //        children: [
          //         const Text("Question 7", style: TextStyle(color: Colors.white),),
          //          Text(widget.answers[6].toString(), style: const TextStyle(color: Colors.white)),
          //        ],
          //      ),
          //     ],
          // ),
        ),
       )
      ):const Center(child:  CircularProgressIndicator(color: Colors.white,)),
    );
  }
}