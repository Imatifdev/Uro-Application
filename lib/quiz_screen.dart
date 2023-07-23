import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();
  bool page1AnsPicked = false;
  bool page2AnsPicked = false;
  bool page3AnsPicked = false;
  bool page4AnsPicked = false;
  bool page5AnsPicked = false;
  bool page6AnsPicked = false;
  bool page7AnsPicked = false;
  int currentPage = 1;
  List<String> questions = [
    "Over the past month, how often have you had the sensation of not emptying your bladder completely after you finish urinating?",
    "Over the past month, how often have you had to urinate again less than two hours after you finished urinating?",
    "Over the past month, how often have you found you stopped and started again several times when you urinated?",
    "Over the past month, how difficult you found it to postpone urination?",
    "Over the past month, how often have you had a weak urinary stream?",
    "Over the past month, how often have you had to push or strain to begin urination?",
    "Over the past month, how many times did you most typically get up to urinate from the time you went to bed until the time you got up in the morning?"
  ];
  List<String> headings = [
    "Incomplete Emptying",
    "Frequency",
    "Intermittency",
    "Urgency",
    "Weak Stream",
    "Straining",
    "Nocturia"
  ];
  
  List<List<String>> answers= [
    ["Not at all","Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all","Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all","Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all","Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all","Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["Not at all","Less than 1 time in 5 days", "Less than half the time", "About half the time", "More than half the time", "Almost always"],
    ["None", "1 Time", "2 Times", "3 Times", "4 Times", "5 Times or more"]
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height/50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page1AnsPicked? Colors.deepPurple:Colors.deepPurple.shade100,
                      child: page1AnsPicked? const Icon(Icons.check): const Text("1", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page2AnsPicked? Colors.deepPurple:Colors.deepPurple.shade100,
                      child: page2AnsPicked? const Icon(Icons.check): const Text("2", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page3AnsPicked? Colors.deepPurple:Colors.deepPurple.shade300,
                      child: page3AnsPicked? const Icon(Icons.check): const Text("3", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page4AnsPicked? Colors.deepPurple:Colors.deepPurple.shade100,
                      child: page4AnsPicked? const Icon(Icons.check): const Text("4", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page5AnsPicked? Colors.deepPurple:Colors.deepPurple.shade100,
                      child: page5AnsPicked? const Icon(Icons.check): const Text("5", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page6AnsPicked? Colors.deepPurple:Colors.deepPurple.shade100,
                      child: page6AnsPicked? const Icon(Icons.check): const Text("6", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                  CircleAvatar(
                    radius: size.aspectRatio*53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: size.aspectRatio*50,
                      backgroundColor: !page7AnsPicked? Colors.deepPurple:Colors.deepPurple.shade100,
                      child: page7AnsPicked? const Icon(Icons.check): const Text("7", style: TextStyle(color: Colors.white),) ,
                    ),
                  ),
                ],),
              SizedBox(
                height: size.height/1.4,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  itemBuilder: (context, index) =>   Card(
                    color: Colors.deepPurple.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(headings[index], style: const TextStyle(fontSize: 20),),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Question No ${index+1}/7", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                            Text(questions[index], style: const TextStyle(fontSize: 18),),
                        ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(currentPage == 1){
                                    page1AnsPicked = !page1AnsPicked;
                                  }
                                });
                              },
                              child: Container(
                                width: size.width-80,
                                height: size.height/15,
                                decoration: BoxDecoration(
                                  color:page1AnsPicked? Colors.deepPurple :Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(child: Text(answers[index][0] , style: TextStyle(color: page1AnsPicked? Colors.white: Colors.deepPurple),)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(currentPage == 1){
                                    page1AnsPicked = !page1AnsPicked;
                                  }
                                });
                              },
                              child: Container(
                                width: size.width-80,
                                height: size.height/15,
                                decoration: BoxDecoration(
                                  color:page1AnsPicked? Colors.deepPurple :Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(child: Text(answers[index][1], style: TextStyle(color: page1AnsPicked? Colors.white: Colors.deepPurple),)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(currentPage == 1){
                                    page1AnsPicked = !page1AnsPicked;
                                  }
                                });
                              },
                              child: Container(
                                width: size.width-80,
                                height: size.height/15,
                                decoration: BoxDecoration(
                                  color:page1AnsPicked? Colors.deepPurple :Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(child: Text(answers[index][2], style: TextStyle(color: page1AnsPicked? Colors.white: Colors.deepPurple),)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(currentPage == 1){
                                    page1AnsPicked = !page1AnsPicked;
                                  }
                                });
                              },
                              child: Container(
                                width: size.width-80,
                                height: size.height/15,
                                decoration: BoxDecoration(
                                  color:page1AnsPicked? Colors.deepPurple :Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(child: Text(answers[index][3], style: TextStyle(color: page1AnsPicked? Colors.white: Colors.deepPurple),)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(currentPage == 1){
                                    page1AnsPicked = !page1AnsPicked;
                                  }
                                });
                              },
                              child: Container(
                                width: size.width-80,
                                height: size.height/15,
                                decoration: BoxDecoration(
                                  color:page1AnsPicked? Colors.deepPurple :Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(child: Text(answers[index][4], style: TextStyle(color: page1AnsPicked? Colors.white: Colors.deepPurple),)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(currentPage == 1){
                                    page1AnsPicked = !page1AnsPicked;
                                  }
                                });
                              },
                              child: Container(
                                width: size.width-80,
                                height: size.height/15,
                                decoration: BoxDecoration(
                                  color:page1AnsPicked? Colors.deepPurple :Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Center(child: Text(answers[index][5], style: TextStyle(color: page1AnsPicked? Colors.white: Colors.deepPurple),)),
                              ),
                            ),
                            ],
                        ),
                        ],
                      ),
                    ),
                    )),
              ),
              Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           CircleAvatar(
                            radius: size.aspectRatio*70,
                            child: IconButton(
                              onPressed: (){
                                _pageController.previousPage(duration: const Duration(seconds: 2), curve: Curves.decelerate);
                              setState(() {
                                if(currentPage!=1){
                                  currentPage--;
                                }
                              });
                              print(currentPage);
                              }, 
                              icon: Icon(Icons.arrow_back_ios_new, size: size.aspectRatio*70,)
                              )
                            ),
                            CircleAvatar(
                              radius: size.aspectRatio*70,
                            child: IconButton(
                              onPressed: (){
                                _pageController.nextPage(duration: const Duration(seconds: 2), curve: Curves.decelerate);
                              setState(() {
                                if(currentPage!=7){
                                  currentPage++;
                                }
                              });
                              print(currentPage);
                              }, 
                              icon: Icon(Icons.arrow_forward_ios_sharp, size:size.aspectRatio*70,)
                              ),  
                            ) 
                          ],
                        )
              // SizedBox(
              //   height: size.height/35,
              // )
            ],
          ),
        ),
      )),
    );
  }
}