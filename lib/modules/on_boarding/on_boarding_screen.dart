import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/models/models.dart';


class On_boarding_Screen extends StatefulWidget {
  @override
  _On_boarding_ScreenState createState() => _On_boarding_ScreenState();
}

class _On_boarding_ScreenState extends State<On_boarding_Screen> {
  var boardController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndEnd(
          context,
          LoginScreen(),
        );
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'On Boarding 1 title',
        body: 'On Boarding 1 body',
        image: 'assets/images/social_on_boarding1.jpg.png'),
    BoardingModel(
        title: 'On Boarding 2 title',
        body: 'On Boarding 2 body',
        image: 'assets/images/social_on_boarding2.png'),
    BoardingModel(
        title: 'On Boarding 3 title',
        body: 'On Boarding 3 body',
        image: 'assets/images/social_on_boarding3.jpg.png')
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: () {
              submit();
              print(CacheHelper.getData(key: 'onBoarding'));

            }, child: Text('SKIP',
              style: TextStyle(
                  color: Colors.black
              ),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else
                        setState(() {
                          isLast = false;
                        });
                    },
                    physics: BouncingScrollPhysics(),
                    controller: boardController,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  )),
              SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.purple,
                        expansionFactor: 4,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5.0
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                        print(CacheHelper.getData(key: 'onBoarding'));
                      }
                      else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                    child: Icon(IconBroken.Arrow___Right_2,color: Colors.white,),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel model) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 20.0,
      ),
    ]);
