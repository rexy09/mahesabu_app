import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionScreenPage extends StatefulWidget {
  IntroductionScreenPage({Key key}) : super(key: key);

  @override
  _IntroductionScreenPageState createState() => _IntroductionScreenPageState();
}

class _IntroductionScreenPageState extends State<IntroductionScreenPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          titleWidget: Text(
            'Hello!',
            style: TextStyle(
              fontSize: 30,
              color: Colors.yellowAccent,
            ),
          ),
          bodyWidget: Text(
            'Welcome to MahesabuApp.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          image: Center(
            child:
                Image.network("https://domaine.com/image.png", height: 175.0),
          ),
          decoration: const PageDecoration(
            pageColor: Colors.purpleAccent,
          ),
        ),
        PageViewModel(
          title: "Easy to calculate!",
          body:
              "Now you can calculate fast and easy your daily business capital.",
          image:
              Center(child: Image.asset("res/images/logo.png", height: 175.0)),
          decoration: const PageDecoration(
            pageColor: Colors.lightBlueAccent,
          ),
        ),
        PageViewModel(
          title: "Store your records",
          body: "Now you can store your business records in your mobile.",
          image: const Center(child: Icon(Icons.android)),
          decoration: const PageDecoration(
            pageColor: Colors.redAccent,
            titleTextStyle: TextStyle(color: Colors.orange),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ),
        PageViewModel(
          title: "See the trend",
          body: "now you can make follow up of your business trend.",
          image: const Center(child: Icon(Icons.android)),
          decoration: const PageDecoration(
            pageColor: Colors.orangeAccent,
          ),
          footer: RaisedButton(
            onPressed: () {
              // On button presed
            },
            child: const Text("Let's Go !"),
          ),
        ),
        PageViewModel(
          title: "Get Started.",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on "),
              Icon(Icons.edit),
              Text(" to edit a post"),
            ],
          ),
          image: const Center(child: Icon(Icons.android)),
          decoration: const PageDecoration(
            pageColor: Colors.greenAccent,
          ),
        )
      ],
      onDone: () {
        // When done button is press
        Navigator.pop(context);
      },
      onSkip: () {
        // You can also override onSkip callback
        Navigator.pop(context);
      },
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.yellowAccent,
      ),
      done: const Text(
        "Done",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.yellow,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
