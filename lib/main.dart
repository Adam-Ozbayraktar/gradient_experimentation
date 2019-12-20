import 'package:flutter/material.dart';
import 'dart:math';
import './emotion_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradients',
      home: GradientTextWidget(),
    );
  }
}

class GradientTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var randomNumber = Random();
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GradientText(
              'Sample Text',
              gradient: LinearGradient(colors: [
                Colors.blue.shade400,
                Colors.blue.shade900,
              ]),
            ),
            GradientText(
              'Sample Text',
              gradient: LinearGradient(colors: [
                Colors.red,
                Colors.pink,
                Colors.purple,
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.indigo,
                Colors.blue,
                Colors.lightBlue,
                Colors.cyan,
                Colors.teal,
                Colors.green,
                Colors.lightGreen,
                Colors.lime,
                Colors.yellow,
                Colors.amber,
                Colors.orange,
                Colors.deepOrange,
              ]),
            ),
            GradientText(
              'Sample text',
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GradientIcon(),
              ],
            ),
            ToggleButtonGradient(),
            GradientIconButtons(
              reaction_1: randomNumber.nextInt(100),
              reaction_2: randomNumber.nextInt(100),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    @required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          // The color must be set to white for this to work
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }
}

class GradientIcon extends StatefulWidget {
  // GradientIcon({@required this.gradient});

  // final Gradient gradient;

  @override
  _GradientIconState createState() => _GradientIconState();
}

class _GradientIconState extends State<GradientIcon> {
  bool buttonSelected = false;
  var gradientBefore = LinearGradient(
    colors: [
      Color.fromRGBO(189, 195, 199, 1),
      Color.fromRGBO(44, 62, 80, 1),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradientBefore.createShader(
        Rect.fromLTWH(0, 0, 50, 50),
      ),
      child: IconButton(
        iconSize: 50,
        icon: Icon(Icons.ac_unit),
        color: Colors.white,
        onPressed: () {
          setState(() {
            if (buttonSelected) {
              buttonSelected = false;
              gradientBefore = LinearGradient(
                colors: [
                  Color.fromRGBO(189, 195, 199, 1),
                  Color.fromRGBO(44, 62, 80, 1),
                ],
              );
            } else {
              buttonSelected = true;
              gradientBefore = LinearGradient(
                colors: [
                  Colors.red,
                  Colors.pink,
                  Colors.purple,
                  Colors.deepPurple,
                  Colors.deepPurple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.lightBlue,
                  Colors.cyan,
                  Colors.teal,
                  Colors.green,
                  Colors.lightGreen,
                  Colors.lime,
                  Colors.yellow,
                  Colors.amber,
                  Colors.orange,
                  Colors.deepOrange,
                ],
              );
            }
          });
        },
      ),
    );
  }
}

class ToggleButtonGradient extends StatefulWidget {
  @override
  _ToggleButtonGradientState createState() => _ToggleButtonGradientState();
}

class _ToggleButtonGradientState extends State<ToggleButtonGradient> {
  List<bool> isSelected;

  var gradientBefore = LinearGradient(
    colors: [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
    ],
  );

  @override
  void initState() {
    isSelected = [false, false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradientBefore.createShader(
        Rect.fromLTWH(0, 0, 375, 50),
      ),
      child: ToggleButtons(
        constraints: BoxConstraints.expand(width: 80, height: 60),
        renderBorder: false,
        // borderRadius: BorderRadius.circular(200),
        selectedColor: Colors.white,
        // highlightColor: Colors.white,
        // fillColor: Colors.white,
        children: <Widget>[
          Icon(Icons.ac_unit, size: 50),
          Icon(Emotion.emo_thumbsup, size: 40),
          Icon(Emotion.emo_displeased, size: 40),
          Icon(Emotion.emo_angry, size: 40),
          Icon(Emotion.emo_cry, size: 40),
        ],
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isSelected.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                isSelected[buttonIndex] = true;
              } else {
                isSelected[buttonIndex] = false;
                // removeReaction(index);
              }
            }
          });
        },
        isSelected: isSelected,
      ),
    );
  }
}

class GradientIconButtons extends StatefulWidget {
  int reaction_1;
  int reaction_2;

  GradientIconButtons({this.reaction_1, this.reaction_2});

  @override
  _GradientIconButtonsState createState() => _GradientIconButtonsState();
}

class _GradientIconButtonsState extends State<GradientIconButtons> {
  bool buttonSelected_1 = false;
  bool buttonSelected_2 = false;

  int currState = -1;
  int prevState = -1;

  int buttonTracker_1 = 0;
  int buttonTracker_2 = 0;

  void reactionTracker(index) {
    currState = index;
    if (prevState == -1) {
      switch (index) {
        case 0:
          {
            widget.reaction_1++;
            buttonTracker_1++;
          }
          break;
        case 1:
          {
            buttonTracker_2++;
            widget.reaction_2++;
          }
          break;
      }
    } else if (prevState != -1 && currState != prevState) {
      switch (prevState) {
        case 0:
          {
            if (buttonTracker_1 % 2 != 0) {
              widget.reaction_1--;
              buttonTracker_1 = 0;
            } else {
              buttonTracker_1 = 0;
            }
          }
          break;
        case 1:
          {
            if (buttonTracker_2 % 2 != 0) {
              widget.reaction_2--;
              buttonTracker_2 = 0;
            } else {
              buttonTracker_2 = 0;
            }
          }
          break;
      }
      switch (index) {
        case 0:
          {
            widget.reaction_1++;
            buttonTracker_1++;
          }
          break;
        case 1:
          {
            widget.reaction_2++;
            buttonTracker_2++;
          }
          break;
      }
    } else if (prevState == currState) {
      switch (index) {
        case 0:
          {
            if (buttonTracker_1 % 2 == 0) {
              widget.reaction_1++;
              buttonTracker_1++;
            } else {
              widget.reaction_1--;
              buttonTracker_1++;
            }
          }
          break;
        case 1:
          {
            if (buttonTracker_2 % 2 == 0) {
              widget.reaction_2++;
              buttonTracker_2++;
            } else {
              widget.reaction_2--;
              buttonTracker_2++;
            }
          }
          break;
      }
    }
    prevState = currState;
  }

  var unselectedGradient_1 = LinearGradient(
    colors: [
      Color.fromRGBO(189, 195, 199, 1),
      Color.fromRGBO(44, 62, 80, 1),
    ],
  );

  var unselectedGradient_2 = LinearGradient(
    colors: [
      Color.fromRGBO(189, 195, 199, 1),
      Color.fromRGBO(44, 62, 80, 1),
    ],
  );

  var gradient_1 = LinearGradient(
    colors: [
      Color.fromRGBO(189, 195, 199, 1),
      Color.fromRGBO(44, 62, 80, 1),
    ],
  );

  var gradient_2 = LinearGradient(
    colors: [
      Color.fromRGBO(189, 195, 199, 1),
      Color.fromRGBO(44, 62, 80, 1),
    ],
  );

  var selectedGradient_1 = LinearGradient(
    colors: [
      Color.fromRGBO(131, 58, 180, 1),
      Color.fromRGBO(253, 29, 29, 1),
      Color.fromRGBO(252, 176, 69, 1),
      // Colors.red,
      // Colors.pink,
      // Colors.purple,
      // Colors.deepPurple,
      // Colors.deepPurple,
      // Colors.indigo,
      // Colors.blue,
      // Colors.lightBlue,
      // Colors.cyan,
      // Colors.teal,
      // Colors.green,
      // Colors.lightGreen,
      // Colors.lime,
      // Colors.yellow,
      // Colors.amber,
      // Colors.orange,
      // Colors.deepOrange,
    ],
  );

  var selectedGradient_2 = LinearGradient(
    colors: [
      Color.fromRGBO(131, 58, 180, 1),
      Color.fromRGBO(253, 29, 29, 1),
      Color.fromRGBO(252, 176, 69, 1),
      // Colors.red,
      // Colors.pink,
      // Colors.purple,
      // Colors.deepPurple,
      // Colors.deepPurple,
      // Colors.indigo,
      // Colors.blue,
      // Colors.lightBlue,
      // Colors.cyan,
      // Colors.teal,
      // Colors.green,
      // Colors.lightGreen,
      // Colors.lime,
      // Colors.yellow,
      // Colors.amber,
      // Colors.orange,
      // Colors.deepOrange,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShaderMask(
              shaderCallback: (bounds) => gradient_1.createShader(
                Rect.fromLTWH(0, 0, 45, 50),
              ),
              child: IconButton(
                iconSize: 40,
                icon: Icon(Emotion.emo_happy),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (buttonSelected_1) {
                      buttonSelected_1 = false;
                      gradient_1 = unselectedGradient_1;
                      reactionTracker(0);
                    } else {
                      buttonSelected_1 = true;
                      buttonSelected_2 = false;
                      gradient_1 = selectedGradient_1;
                      gradient_2 = unselectedGradient_2;
                      reactionTracker(0);
                    }
                  });
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ShaderMask(
              shaderCallback: (bounds) => gradient_2.createShader(
                Rect.fromLTWH(0, 0, 45, 50),
              ),
              child: IconButton(
                iconSize: 45,
                icon: Icon(Emotion.emo_cry),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (buttonSelected_2) {
                      buttonSelected_2 = false;
                      gradient_2 = unselectedGradient_2;
                      reactionTracker(1);
                    } else {
                      buttonSelected_2 = true;
                      buttonSelected_1 = false;
                      gradient_1 = unselectedGradient_1;
                      gradient_2 = selectedGradient_2;
                      reactionTracker(1);
                    }
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.reaction_1}',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              width: 35,
            ),
            Text(
              '${widget.reaction_2}',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        Text(
          'Total Reactions: ${widget.reaction_1 + widget.reaction_2}',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Text(
          'Button 1: $buttonTracker_1',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Text(
          'Button 2: $buttonTracker_2',
          style: TextStyle(
            fontSize: 30,
          ),
        )
      ],
    );
  }
}
