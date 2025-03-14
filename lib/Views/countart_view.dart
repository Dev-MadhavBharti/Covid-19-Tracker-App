

import 'package:flutter/material.dart';

class CountartView extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  CountartView({

    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.totalDeaths,
  });

  @override
  State<CountartView> createState() => _CountartViewState();
}

class _CountartViewState extends State<CountartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children:[ Card(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.image),
                    ),
                    SizedBox(height:40,),
                    ReusableRow(title: 'Cases', value:widget.totalCases.toString()),
                    ReusableRow(title: 'Recovered', value:widget.totalRecovered.toString()),
                    ReusableRow(title: 'Cases', value:widget.totalCases.toString()),
                    ReusableRow(title: 'Active', value:widget.active.toString()),
                    ReusableRow(title: 'Deaths', value:widget.totalDeaths.toString()),
                    ReusableRow(title: 'Critical', value:widget.critical.toString()),
                    ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString())

                  ],
                ),
              ),
            ]),
          ],
        ),
      ),

    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
