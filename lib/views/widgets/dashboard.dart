import 'package:flutter/material.dart';
import 'package:ifstatic_technology_task/repository/api/get_resturants_api.dart';
import 'package:ifstatic_technology_task/repository/data_fetcher.dart';
import 'package:ifstatic_technology_task/repository/location_fetcher.dart';

import '../../constants/consts.dart';
import '../../repository/models/get_resturants_model.dart';

class DashboardUI extends StatefulWidget {
  const DashboardUI({super.key});

  @override
  State<DashboardUI> createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
 

  dynamic apiRes = APIDataFetcher().apiResponse;
  @override
  Widget build(BuildContext context) {
    // dynamic apiRes = APIDataFetcher().apiResponse;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: apiRes?.data.length,
      itemBuilder: (context, index) {
        List<Restaurant> result = apiRes!.data;
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 10,
                    color: Color(0xffffe1e1))
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 0, bottom: 10, left: 10),
                    child: Text(
                      result[index].name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Row(
                      children: [
                        Image.asset(
                          Svgs.discount,
                          height: 20,
                          width: 20,
                        ),
                        Text('${result[index].discount.toString()}% FLAT OFF',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffFF0000))),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
