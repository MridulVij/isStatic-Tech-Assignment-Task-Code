import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constants/consts.dart';
import '../repository/models/get_resturants_model.dart';
import 'widgets/custom_appbar.dart';
import 'widgets/custom_buttons.dart';

enum FoodCategories {
  burger,
  spinach,
  chicken,
  pizza,
  all,
}

class HomeUI extends StatefulWidget {
  const HomeUI({
    super.key,
    required this.address,
    required this.apiResponse,
  });

  final String address;
  final ApiResponse apiResponse;

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  var all = FoodCategories.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    size: 15,
                    color: Colors.black,
                  ),
                  Text(widget.address),
                ],
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 10, top: 1),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Gap(10),
                    CustomSelector(
                      path: '',
                      forwardIcon: false,
                      backwardIcon: false,
                      centerText: true,
                      titleText: "All",
                      isSquareShapeButton: false,
                      isSelected: all == FoodCategories.all,
                      onPress: () {
                        setState(() {
                          all = FoodCategories.all;
                        });
                      },
                    ),
                    const Gap(10),
                    CustomSelector(
                      path: Svgs.pizza,
                      forwardIcon: false,
                      backwardIcon: true,
                      centerText: false,
                      titleText: "Pizza",
                      isSquareShapeButton: false,
                      isSelected: all == FoodCategories.pizza,
                      onPress: () {
                        setState(() {
                          all = FoodCategories.pizza;
                        });
                      },
                    ),
                    const Gap(10),
                    CustomSelector(
                      path: Svgs.chicken,
                      forwardIcon: false,
                      backwardIcon: true,
                      centerText: false,
                      titleText: "",
                      isSquareShapeButton: false,
                      isSelected: all == FoodCategories.chicken,
                      onPress: () {
                        setState(() {
                          all = FoodCategories.chicken;
                        });
                      },
                    ),
                    const Gap(10),
                    CustomSelector(
                      path: Svgs.salad,
                      forwardIcon: false,
                      backwardIcon: true,
                      centerText: false,
                      titleText: '',
                      isSquareShapeButton: false,
                      isSelected: all == FoodCategories.spinach,
                      onPress: () {
                        setState(() {
                          all = FoodCategories.spinach;
                        });
                      },
                    ),
                    const Gap(10),
                    CustomSelector(
                      path: Svgs.burger,
                      forwardIcon: false,
                      backwardIcon: true,
                      centerText: false,
                      titleText: "",
                      isSquareShapeButton: false,
                      isSelected: all == FoodCategories.burger,
                      onPress: () {
                        setState(() {
                          all = FoodCategories.burger;
                        });
                      },
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              Container(
                width: 344,
                height: 51,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.5),
                    color: Colors.white),
                child: Center(
                  child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search Food items")),
                ),
              )
            ],
          )),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.apiResponse.data.length,
        itemBuilder: (context, index) {
          List<Restaurant> result = widget.apiResponse.data;
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 5,
                      color: Color(0xffffe1e1))
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(result[index].primaryImage)),
                  Positioned(
                      bottom: 8,
                      right: 6,
                      child: Container(
                          height: 20,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('${result[index].rating.toString()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700)),
                          )))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    result[index].name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      // Image.asset(name),
                      Text('${result[index].discount.toString()}% FLAT OFF',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffFF0000))),
                    ],
                  )
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
