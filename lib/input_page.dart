import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'bottomContainer.dart';
import 'result.dart';
import 'calculator_brain.dart';

enum Gender {
  // Gender acts as a data type.
  male,
  female
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  Color colour;
  int height = 180;
  int weight = 50;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onpress: () {
                      //pass function
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveColour
                        : kInactiveColour,
                    containerChild: IconDetails(
                      label: "MALE",
                      icon: FontAwesomeIcons.mars,
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    //starts female card
                    onpress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveColour
                        : kInactiveColour,
                    containerChild: IconDetails(
                      label: "FEMALE",
                      icon: FontAwesomeIcons.venus,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              //slider wala container
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  colour: kActiveColour,
                  containerChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "HEIGHT",
                        style: kTextStyles,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            height.toString(),
                            style: kNumStyle,
                          ),
                          Text("cm"),
                        ],
                      ),
                      Slider(
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                        value: height.toDouble(),
                        min: 120,
                        max: 220,
                        activeColor: Color(0xFFEB1555),
                        inactiveColor: Color(0xFF8D8E98),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            // weight wala widget
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveColour,
                    containerChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "WEIGHT",
                          style: kTextStyles,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumStyle,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onpress: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onpress: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                      colour: kActiveColour,
                      containerChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "AGE",
                            style: kTextStyles,
                          ),
                          Text(
                            age.toString(),
                            style: kNumStyle,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onpress: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onpress: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          bottomContainer(
            label: "CALCULATE",
            ontap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    bmiDetails: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class IconDetails extends StatelessWidget {
  IconDetails({@required this.label, @required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(height: 10.0),
        Text(
          label,
          style: kTextStyles,
        ),
      ],
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.containerChild, this.onpress});

  final Widget containerChild;
  final Color colour;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        child: containerChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colour,
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, this.onpress});

  final IconData icon;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onpress,
        child: Icon(icon),
        disabledElevation: 6.0,
        elevation: 6.0,
        shape: CircleBorder(),
        fillColor: Color(0xFF4C4F5E),
        constraints: BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ));
  }
}
