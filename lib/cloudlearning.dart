import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';



class CloudLearning extends StatefulWidget {
  const CloudLearning({super.key});

  @override
  State<CloudLearning> createState() => _CloudLearningState();
}

class _CloudLearningState extends State<CloudLearning> {
  final pages = const [
    {
      'questionText': 'Let\'s learn about identifying clouds!',
      'answers': [
        {'text': 'Here you will learn about different clouds and what they look like. Click the text to continue!', 'score': 4},//cirrus

      ]
    },
    {
      'questionText': 'Cirrus clouds',
      'answers': [
        {'text': 'These clouds are short, detached, hair-like clouds found at high altitudes. The MET office describes them as "wispy with a silky sheen"', 'score': 2},//nimbus
      ],
      'image': 'cirrus.jpg'
    },
    {
      'questionText': 'Stratus Clouds',
      'answers': [
        {'text': 'Stratus clouds cover much of the sky and float lower down than cirrus clouds, they are low-level layers with a fairly uniform grey or white colour', 'score': 3},//stratus
      ],
      'image': 'stratus.jpg'
    },
    {
      'questionText': 'Nimbus Clouds',
      'answers': [
        {'text': 'Dark, grey, featureless layers of cloud that block out the sun itself', 'score': 2},//cumulus, nimbus
      ],
      'image':'nimbus.jpg'
    },
    {
      'questionText': 'Cumulus Clouds',
      'answers': [
        {'text': 'These clouds are white and fluffy! if you\'ve ever seen shapes in the clouds, they were probably cumulus!', 'score': 1},//cumulus
      ],
      'image':'cumulus.jpg'
    },
  ];

  int pageindex = 0;
  List<int> answers = [];
  double opacityc = 0.0;
  double opacityct = 0.0;
  double opacityb = 0.0;
  late String cloudType;

  void _nextPage() {
    Vibration.vibrate(duration: 25);
    setState(() {
      pageindex += 1;
    });

    if (pageindex >= pages.length){
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          opacityc = 1.0;
        });
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          opacityct = 1.0;
        });
      });

      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          opacityb = 1.0;
        });
      });
    }
  }

  void _restart() {
    Vibration.vibrate(duration: 25);
    setState(() {
      pageindex = 0;
      answers = [];
      opacityc = 0.0;
      opacityct = 0.0;
      opacityb = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFA7E2E3), Color(0xFF2D728F)],
          ),
        ),
        child: Center(
          child: pageindex < pages.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pageindex != 0)
              Image(image: AssetImage("assets/${pages[pageindex]['image']}")),
              Text(
                pages[pageindex]['questionText'] as String,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ...(pages[pageindex]['answers'] as List<Map<String, Object>>)
                  .map((answer) {
                return Column(
                  children: [
                    Text(answer['text'] as String),
                  SizedBox(height:10)
                ]
                );
              }),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Color(0xFF2D728F)),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => _nextPage(),
                child: Text("Next"),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: opacityc,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Congratulations, you\'re now a cloud expert!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: opacityb,
                duration: const Duration(seconds: 1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                    WidgetStateProperty.all<Color>(const Color(0xFF2D728F)),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: _restart,
                  child: const Text('Back to the beginning...'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}