import 'package:flutter/material.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFA7E2E3), Color(0xFF2D728F)],
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'Notice Board',
                    style: TextStyle(
                      fontSize: 56,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.white,
                ),

                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:'Notice Number 4 - Cloud Quiz added'"\n\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text:'- New personality quiz added to learn what type of cloud you are!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF2D728F),
                              fontWeight: FontWeight.bold,
                          ),
                        ),

                      ]
                  ),
                  ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text:'Notice Number 3 - Maintenance concluded'"\n\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text:'- We at clapp thank you for your patience during this maintenance period, it is greatly appreciated. ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ]
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.white,
                ),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text:'Notice Number 2 - Technical difficulties'"\n\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text:'- There will be a scheduled maintenance from 01/04/24 - 05/04/24 to fix optimisation problems, we apologise for any inconvenience.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ]
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.white,
                ),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      children: [
                        TextSpan(

                          text:'Notice Number 1 - Official launch day! 0u0'"\n\n",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text:'- Thank you all for your continued support as we launch clapp, we hope you all enjoy!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF2D728F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}