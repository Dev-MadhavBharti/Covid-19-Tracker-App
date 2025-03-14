import 'package:covid_tracker/Views/countart_view.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),

            /// Search bar Widget
            child: TextField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: _searchController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),

          Expanded(
            child: FutureBuilder(
                future: statesServices.CountriesListApi(),
                builder: (context , AsyncSnapshot<List<dynamic>> snapshot) {
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          /// 🟢 Show shimmer effect while loading
                     return Shimmer.fromColors(
                         baseColor:Colors.grey.shade700,
                         highlightColor: Colors.grey.shade100,
                       child: Column(
                         children: [
                           ListTile(
                             leading: Container( height: 50, width: 50, color: Colors.white,),
                             title: Container(height: 10,width: 89, color: Colors.white,),
                             subtitle: Container(
                               height: 10,
                               width: 89,
                               color: Colors.white,
                             ),
                           )
                         ],
                       ),

      );
                    }
                  );
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                      if(_searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> CountartView(
                               name: snapshot.data![index]['country'],
                               image: snapshot.data![index]['countryInfo']['flag'],
                               totalCases: snapshot.data![index]['cases'] ?? 0,
                               totalRecovered: snapshot.data![index]['recovered'] ?? 0,
                               active: snapshot.data![index]['active'] ?? 0,
                               test: snapshot.data![index]['tests'] ?? 0,
                               todayRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                               critical: snapshot.data![index]['critical'] ?? 0,
                               totalDeaths: snapshot.data![index]['deaths'] ?? 0,


                             ))) ;
                        },
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag']),
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      }else if(snapshot.data![index]['country'].toLowerCase().contains(_searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag']),
                                width: 50,
                                height: 50,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            )
                          ],
                        );
                      }else{
                        return Container();
                      }
                      ///
                      return Column(
                        children: [
                          ListTile(
                            leading: Image(
                              image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag']),
                              width: 50,
                              height: 50,
                            ),
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                          )
                        ],
                      );
                    });
                  }
                }
                ),
          ),
        ],
      )),
    );
  }
}
