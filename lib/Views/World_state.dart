import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/Views/Countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2));



  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder<WorldStatesModel>(
                  future: statesServices.fetchWorldStatesRecords(), // Ensure this function does not return null
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitCircle(
                            color: Colors.white,
                            controller: _controller,
                            size: 50.0,
                          ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error fetching data"));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text("No data available"));
                    }
                    else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total":
                                    double.parse(snapshot.data!.cases.toString()),
                                "Recover": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Death": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                    ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                    ReusableRow(title: 'Deadths', value: snapshot.data!.deaths.toString()),
                                    ReusableRow(title: 'Crirical', value: snapshot.data!.critical.toString()),
                                    ReusableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                                    ReusableRow(title: "Today deaths", value: snapshot.data!.todayDeaths.toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesList()));
                              },
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "Track Countries",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
      ),
      ),
    ));
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
