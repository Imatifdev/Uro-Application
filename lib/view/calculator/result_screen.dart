import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  final List answers;
  final num avg;
  final int qNum;
  const ResultScreen({super.key, required this.answers, required this.avg, required this.qNum});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Show the progress indicator for 3 seconds using Future.delayed
    // Future.delayed(const Duration(seconds: 3), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int questionScore = widget.qNum == 7? 35:25;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: 
      SafeArea(child: 
      SizedBox(
        height: size.height-100,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Result", style: TextStyle(color: Colors.white, fontSize: 22),)),
              LinearPercentIndicator(
                  // radius:90.0,
                  // lineWidth: 15.0,
                  //width: size.width-30,
                  lineHeight: 40,
                  barRadius: const Radius.circular(15),
                  //trailing: 
                  percent: ((widget.avg/questionScore)),
                  center: Text("${((widget.avg/questionScore)*100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.black),),
                  animation: true,
                  animationDuration: 1800,
                  curve: Curves.bounceOut,
                  // rotateLinearGradient: true,
                  // circularStrokeCap: CircularStrokeCap.round,
                  linearGradient: const LinearGradient(colors: [Colors.green, Colors.yellow ,Colors.red]) ,
                  //progressColor: Colors.green,
                ),
              Text("According to our calculator there is ${((widget.avg/questionScore)*100).toStringAsFixed(1)}% chance that you have a problem", textAlign: TextAlign.center ,style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 60*7,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics() ,
                  itemCount: widget.answers.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text("Question ${index+1}", style: const TextStyle(color: Colors.white),), 
                   trailing: Text(widget.answers[index].toString(), style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ),),
              ),
              SizedBox(
                width: size.width-100,
                child: Card(
                  shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
      //set border radius more than 50% of height and width to make circle
  ),
                  color: Colors.pink.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child:  Text("Your Score", style: TextStyle(color: Colors.black, fontSize: 18))),
                        Text("${widget.avg.toString()}/$questionScore", style: const TextStyle(color: Colors.black,fontSize: 30 )),
                      ],
                    ),
                  ),
                ),
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
      )
      );
  }
}