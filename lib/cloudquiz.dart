import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

String calculatePersonality(List<int> userAnswers) {
  //Stores the cloud types as keys and initialises them as 0
  Map<String, int> cloudScores = {
    'Cirrus': 0,
    'Stratus': 0,
    'Nimbus': 0,
    'Cumulus': 0,
  };

  //defines which number corresponds to which cloud type
  Map<int, String> scoreToCloud = {
    4: 'Cirrus',
    3: 'Stratus',
    2: 'Nimbus',
    1: 'Cumulus',
  };

  //loops through the answers and increments the cloud type depending on what cloud type the answer was
  for (int score in userAnswers) {
    //! means it won't be null, and if it somehow is, crash the app
    String cloudType = scoreToCloud[score]!;
    cloudScores[cloudType] = (cloudScores[cloudType]! + 1);
  }

  //finds the cloud with the highest score
  String dominantCloud = cloudScores.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  return dominantCloud;
}

class CloudQuiz extends StatefulWidget {
  const CloudQuiz({super.key});

  @override
  State<CloudQuiz> createState() => _CloudQuizState();
}

class _CloudQuizState extends State<CloudQuiz> {
  final questions = const [
    {
      'questionText': 'What\'s your favourite weather?',
      'answers': [
        {'text': 'Rain', 'score': 4},//cirrus
        {'text': 'Snow', 'score': 2},//stratus
        {'text': 'Thunderstorm', 'score': 3},//nimbus
        {'text': 'Sunny', 'score': 1}//cumulus
      ]
    },
    {
      'questionText': 'How would you describe yourself?',
      'answers': [
        {'text': 'Confident and Brave', 'score': 2},//nimbus
        {'text': 'Wise and Mature', 'score': 4},//cirrus
        {'text': 'Kind and Loyal', 'score': 3},//stratus
        {'text': 'Sweet and Fun', 'score': 1},//cumulus
      ]
    },
    {
      'questionText': 'It\'s raining heavily outside and your friend forgot an umbrella! What do you do?',
      'answers': [
        {'text': 'Share the umbrella with them', 'score': 3},//stratus
        {'text': 'Turn to them and go "WOMP WOMP" in their face', 'score': 2},//nimbus
        {'text': 'Give them your own', 'score': 1},//cumulus
        {'text': 'Tell them to use their jacket as a cover', 'score': 4}//cirrus
      ]
    },
    {
      'questionText': 'Hot or Cold?',
      'answers': [
        {'text': 'Hot', 'score': 2},//cumulus, nimbus
        {'text': 'Cold', 'score': 4},//cirrus, stratus
      ]
    },
    {
      'questionText': 'Dream holiday destination?',
      'answers': [
        {'text': 'Paris', 'score': 1},//cumulus
        {'text': 'New York', 'score': 2},//nimbus
        {'text': 'Tokyo', 'score': 3},//stratus
        {'text': 'The Alps', 'score': 4}//cirrus
      ]
    },
    {
      'questionText': 'It\'s a snow day! What do you do?',
      'answers': [
        {'text': 'Go outside and build a snowman', 'score': 1},//cumulus
        {'text': 'Binge Watch TV Shows', 'score': 3},//stratus
        {'text': 'Curl up with a good book', 'score': 4},//cirrus
        {'text': '"Snow won\'t change my plans!"', 'score': 2},//nimbus
      ]
    },
  ];

  bool showStartScreen = true;
  int questionIndex = 0;
  List<int> answers = [];
  double opacityC = 0.0;
  double opacityCT = 0.0;
  double opacityB = 0.0;
  late String cloudType;


  void startQuiz(){
    setState(() {
      showStartScreen = false;
    });
  }

  void answerQuestion(int score) {
    Vibration.vibrate(duration: 25);
    setState(() {
      answers.add(score);
      questionIndex += 1;
    });

    if (questionIndex >= questions.length){
      cloudType = calculatePersonality(answers);
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          opacityC = 1.0;
        });
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          opacityCT = 1.0;
        });
      });

      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          opacityB = 1.0;
        });
      });
    }
  }

  void _resetQuiz() {
    Vibration.vibrate(duration: 25);
    setState(() {
      questionIndex = 0;
      answers = [];
      opacityC = 0.0;
      opacityCT = 0.0;
      opacityB = 0.0;
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
          child: showStartScreen
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to the Cloud Personality Quiz!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(const Color(0xFF2D728F)),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
                onPressed: startQuiz,
                child: const Text('Start Quiz'),
              ),
            ],
          )
          : questionIndex < questions.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
              child: Text(
                questions[questionIndex]['questionText'] as String,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              ),
              const SizedBox(height: 20),
              ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
                  .map((answer) {
                return Column(
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(Color(0xFF2D728F)),
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () => answerQuestion(answer['score'] as int),
                    child: Text(answer['text'] as String),
                  ),
                  SizedBox(height:10)
                ]
                );
              }),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: opacityC,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Quiz Completed!',
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
                opacity: opacityCT,
                duration: const Duration(seconds: 1),
                child: Text(
                  'Your cloud type is: $cloudType',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: opacityB,
                duration: const Duration(seconds: 1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                    WidgetStateProperty.all<Color>(const Color(0xFF2D728F)),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: _resetQuiz,
                  child: const Text('Restart Quiz'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}