import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'round_icon_button.dart';
import 'boutom_button.dart';
import 'result_page.dart';
import 'calculator_brain.dart';

enum EnumGender { Male, Female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

int height = 180;
int weight = 60;
int age = 20;
EnumGender selectedGender;

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: selectedGender == EnumGender.Male
                        ? kactiveCardColor
                        : kinactiveCardColor,
                    onPress: () =>
                        setState(() => selectedGender = EnumGender.Male),
                    cardChild: iconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                    child: ReusableCard(
                  colour: selectedGender == EnumGender.Female
                      ? kactiveCardColor
                      : kinactiveCardColor,
                  onPress: () =>
                      setState(() => selectedGender = EnumGender.Female),
                  cardChild: iconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ))
              ],
            )),
            Expanded(
              child: ReusableCard(
                colour: kactiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "HEIGHT",
                      style: klabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: kNumberStyle,
                        ),
                        Text(
                          'cm',
                          style: klabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 23.0),
                          overlayColor: Color(0x29FEB1555)),
                      child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          activeColor: Color(0xFFEB1555),
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double newValue) =>
                              setState(() => height = newValue.round())),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                      colour: kactiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "WEIGHT",
                            style: klabelTextStyle,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () => setState(() {
                                      weight--;
                                      if (weight < 0) {
                                        weight = 0;
                                      }
                                    }),
                              )),
                              Expanded(
                                  child: RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () => setState(() {
                                      weight++;
                                    }),
                              ))
                            ],
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: ReusableCard(
                      colour: kactiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "AGE",
                            style: klabelTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () => setState(() {
                                      age--;
                                      if (age < 1) {
                                        age = 1;
                                      }
                                    }),
                              )),
                              Expanded(
                                  child: RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () => setState(() {
                                      age++;
                                    }),
                              ))
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            )),
            BoutomButton(
                buttonTitle: "Calculate",
                onTap: () {
                  CalculatorBrain calc =
                      CalculatorBrain(weight: weight, height: height);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultsPage(
                                bmiResult: calc.calculateBmi(),
                                resultText: calc.getResult(),
                                interpretation: calc.getInterpertuation(),
                              )));
                })
          ],
        ));
  }
}
