import 'package:C1O2/helpers/helpers.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../result/result_screen.dart';
import './user_input_questions.dart';
import '../../helpers/colors.dart';

class UserInputs extends StatefulWidget {
  String args;
  UserInputs({@required this.args});
  @override
  _UserInputsState createState() => _UserInputsState(); //to call a method multiple times
}

class _UserInputsState extends State<UserInputs> { // logic and internal state of a widget
  List answers = [];

  var index = 0;

  final _answerController = TextEditingController(); //created a coltroller to edit the

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as String;
    final size = MediaQuery.of(context).size;

    List foodQ = Provider.of<Questions>(context).foodQuestions as List;
    List travelQ = Provider.of<Questions>(context).travelQuestions as List;
    List waterQ = Provider.of<Questions>(context).waterQuestions as List;

    List questions = [];

    // print(args);

    if (widget.args == 'food') {
      questions = foodQ;
    } else if (widget.args == 'travel') {
      questions = travelQ;
    } else {
      questions = waterQ;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: widget.args == 'food' // select the fod type
              ? Stack(
                  children: [
                    Container(
                      color: ColorPallete.background,
                    ),
                    Positioned(
                      child: FlareActor( //declaring the flare file
                        'assets/flare/base_two_flow.flr',
                        animation: 'flow', //type of an animation
                        fit: BoxFit.cover,
                        color: ColorPallete.background,
                      ),
                    ),
                    if (index == 0 || index == 1)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FlareActor(
                          'assets/flare/food_1.flr',
                          animation: 'flow',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    if (index == 2 || index == 3)
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset(
                          'assets/images/eat_1.png',
                        ),
                      ),
                    Positioned(
                      top: 150,
                      child: Container(
                        height: size.height,
                        width: size.width,
                        //decoration: BoxDecoration(color: ColorPallete.background),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center, //childrean should be placed
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.symmetric( //for vertical and horizontal vertices
                                  horizontal: 40.0,
                                ),
                                child: Text(
                                  questions[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorPallete.color3,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Align(
                              child: Container(
                                width: size.width * 0.4,
                                child: TextFormField(
                                  controller: _answerController,
                                  decoration: InputDecoration(
                                    hintText: '(In Grams)',
                                    hintStyle:
                                        TextStyle(color: ColorPallete.color4),
                                    suffixIcon: IconButton( //suffix icon that will call after declaring something
                                      icon: Icon(
                                        Icons.trending_flat,
                                        color: ColorPallete.color3,
                                      ),
                                      onPressed: () {
                                        if (_answerController.text == '' ||
                                            _answerController is String) {
                                          return;
                                        }
                                        answers.add(double.parse(
                                            _answerController.text));
                                        if (index == questions.length - 1) {
                                          // print(answers);

                                          double footprint = CarbonFootPrint
                                              .getDailyFoodCarbonFootPrint(
                                                  answers[0],
                                                  answers[1],
                                                  answers[2],
                                                  answers[3]);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResultScreen(
                                                        userEmission: footprint,
                                                        averageEmission:
                                                            CarbonFootPrint
                                                                .avgEmissionDueToFoodPerDay,
                                                        activityName: "Food",
                                                      )));
                                        } else {
                                          index++;
                                        }
                                        _answerController.text = '';
                                        setState(() {}); //internal state object is created
                                      },
                                    ),
                                    alignLabelWithHint: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 2,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: ColorPallete.color3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : widget.args == 'travel'
                  ? Stack(
                      children: [
                        Container(
                          color: ColorPallete.background,
                        ),
                        Positioned(
                          child: FlareActor(
                            'assets/flare/base_one.flr',
                            animation: 'Flow',
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (index == 0 || index == 2)
                          FlareActor(
                            'assets/flare/bicycle_flow.flr',
                            animation: 'flow',
                            alignment: Alignment.bottomCenter,
                          ),
                        if (index == 1)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: size.height * 0.3,
                              child: Image.asset(
                                'assets/images/car.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        Positioned(
                          child: Container(
                            height: size.height,
                            width: size.width,
                            //decoration: BoxDecoration(color: ColorPallete.background),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Text(
                                      questions[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorPallete.color3,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: TextFormField(
                                      controller: _answerController,
                                      decoration: InputDecoration(
                                        hintText: '(In miles)',
                                        hintStyle: TextStyle(
                                            color: ColorPallete.color4),
                                        //enabledBorder: InputBorder.none,
                                        //filled: true,
                                        //fillColor: ColorPallete.background.withBlue(-200),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.trending_flat,
                                            color: ColorPallete.color3,
                                          ),
                                          onPressed: () {
                                            if (_answerController.text == '' ||
                                                _answerController is String) {
                                              return;
                                            }
                                            answers.add(double.parse(
                                                _answerController.text));

                                            if (index == questions.length - 1) {
                                              // print(answers);

                                              double footprint = CarbonFootPrint
                                                  .getDailyTravelFootPrint(
                                                      answers[0],
                                                      answers[1],
                                                      answers[2]);

                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ResultScreen(
                                                            userEmission:
                                                                footprint,
                                                            averageEmission:
                                                                CarbonFootPrint
                                                                    .avgEmissionDueToTravelPerDay,
                                                            activityName:
                                                                "Travel",
                                                          )));
                                            } else {
                                              index++;
                                            }
                                            _answerController.text = '';
                                            setState(() {});
                                          },
                                        ),
                                        alignLabelWithHint: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 2,
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: ColorPallete.color3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Container(
                          color: ColorPallete.background,
                        ),
                        Positioned(
                          child: FlareActor(
                            'assets/flare/base_water.flr',
                            animation: 'island01',
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (index == 0 || index == 1 || index == 2)
                          FlareActor(
                            'assets/flare/watch_tv.flr',
                            animation: 'flow',
                            alignment: Alignment.bottomCenter,
                          ),
                        if (index == 3)
                          FlareActor(
                            'assets/flare/water_flow.flr',
                            animation: 'flow',
                            alignment: Alignment.bottomRight,
                            fit: BoxFit.fitWidth,
                          ),
                        Positioned(
                          child: Container(
                            height: size.height,
                            width: size.width,
                            //decoration: BoxDecoration(color: ColorPallete.background),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Text(
                                      questions[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorPallete.color3,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: TextFormField(
                                      controller: _answerController,
                                      decoration: InputDecoration(
                                        hintText: index == 3 ? '' : '(In Hrs)',
                                        hintStyle: TextStyle(
                                            color: ColorPallete.color4),
                                        //enabledBorder: InputBorder.none,
                                        //filled: true,
                                        //fillColor: ColorPallete.background.withBlue(-200),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.trending_flat,
                                            color: ColorPallete.color3,
                                          ),
                                          onPressed: () {
                                            if (_answerController.text == '' ||
                                                _answerController is String) {
                                              return;
                                            }
                                            answers.add(double.parse(
                                                _answerController.text));

                                            if (index == questions.length - 1) {
                                              // print(answers);

                                              double footprint = CarbonFootPrint
                                                  .getDailyHouseHoldCarbonFootPrint(
                                                      answers[0],
                                                      answers[1],
                                                      answers[2],
                                                      answers[3]);

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResultScreen(
                                                    userEmission: footprint,
                                                    averageEmission: CarbonFootPrint
                                                        .avgEmissionDueToHouseHoldPerDay,
                                                    activityName: "HouseHold",
                                                  ),
                                                ),
                                              );
                                            } else {
                                              index++;
                                            }
                                            _answerController.text = '';
                                            setState(() {});
                                          },
                                        ),
                                        alignLabelWithHint: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 2,
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: ColorPallete.color3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
