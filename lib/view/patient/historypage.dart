import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'history_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Adjust font size based on screen width and text scale factor
    //final fontSize = screenWidth * 0.14 * textScaleFactor;
    final subheading1 = screenWidth * 0.07 * textScaleFactor;
    final subheading2 = screenWidth * 0.05 * textScaleFactor;

    return Scaffold(
      backgroundColor: Color(0xff0047ba),
      appBar: AppBar(
        toolbarHeight: hieght * 0.09,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 80,
        ),
        elevation: 0,
        backgroundColor: Color(0xff0047ba),
        leading: IconButton(
          icon: Icon(CupertinoIcons.left_chevron),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: hieght * 0.1,
          ),
          Image.asset(
            'assets/history.png',
            height: hieght * 0.3,
            width: width,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: hieght * 0.05,
          ),
          Text(
            AppLocalizations.of(context)!.downloadhistory,
            style: TextStyle(
                fontSize: subheading1,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: hieght * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.center,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tileColor: Color(0xff3d6bb4),
                  leading: Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.oabHistory,
                    style:
                        TextStyle(fontSize: subheading2, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuizHistoryScreen(
                        quiz: 'Quiz1History',
                      ),
                    ));
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.center,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  tileColor: Color(0xff3d6bb4),
                  leading: Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.ipssHistory,
                    style:
                        TextStyle(fontSize: subheading2, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizHistoryScreen(
                              quiz: 'Quiz2History',
                            )));
                  },
                )),
          ),
        ],
      ),
    );
  }
}
