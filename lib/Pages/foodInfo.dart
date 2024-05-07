import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';
import 'package:beslenme/Pages/BesinDetay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodsInfo extends StatefulWidget {
  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<FoodsInfo> {
  List<Map<String,dynamic>> dataList = [];
  List<String> urlList = [];
  List<Map<String,dynamic>> filteredList = [];
  int itemCount = 0;
  bool isLoading = false;
  bool searhing = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    loadData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange){
      ///Kullanıcı listenin sonuna ulaştı, daha fazla veri yükle
      loadData();
    }
  }

  Future<void> loadData() async {

    if(!isLoading) {
      setState(() {
        isLoading = true;
        itemCount+=100;
      });


      String jsonData = await rootBundle.loadString('assets/data.json');
      List<dynamic> jsonList = json.decode(jsonData);

      String urls = "assets/urls.txt";
      String data = await rootBundle.loadString(urls);
      urlList = data.split('\n');

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        dataList.addAll(jsonList.cast<Map<String, dynamic>>());
        filteredList.addAll(dataList);
        isLoading = false;
      });
    }
  }

  void filteredData(String query){
    List<Map<String,dynamic>> tempList = [];
    tempList.addAll(dataList);
    if(query.isNotEmpty){
      searhing = true;
      tempList = tempList.where((item) {
        String foodName = item["foodname"].toString().toLowerCase();
        return foodName.contains(query.toLowerCase());
      }).toList();
    }
    else{
      searhing = false;
    }
    setState(() {
      filteredList.clear();
      filteredList.addAll(tempList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value){
            filteredData(value);
          },
          decoration: InputDecoration(
            hintText: "Besin Ara...",
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: (){
            filteredData(_searchController.text);
          },
              icon: Icon(Icons.search))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
          controller: _scrollController,
          itemCount: searhing ? filteredList.length +1 : itemCount,
          itemBuilder: (context, index) {
            if(index < filteredList.length){
              var item = filteredList[index];
              var url = urlList[index*2];
              var altarnativeUrl = urlList[index*2 +1];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 2),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: (index%2==0) ?
                      [Colors.green.withOpacity(0.4),Colors.green.withOpacity(0.6)] :
                      [Colors.green.withOpacity(0.6),Colors.green.withOpacity(0.4)]
                    )
                  ),
                  child: GestureDetector(
                    onTap: (){
                      print("LİSTE DEDECTOR: " + urlList.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodDetails(
                            foodName: item["foodname"], energy: double.tryParse(item["Energy"].toString()), carbohydrate: double.tryParse(item["Carbohydrate"].toString()),
                            protein: double.tryParse(item["Protein"].toString()), totalFat: double.tryParse(item["Total Fat"].toString()), water: double.tryParse(item["Water"].toString()),
                            sugars: double.tryParse(item["Sugars"].toString()), calcium: double.tryParse(item["Calcium"].toString()), iron: double.tryParse(item["Iron"].toString()),
                            magnesium: double.tryParse(item["Magnesium"].toString()), potassium: double.tryParse(item["Potassium"].toString()), sodium: double.tryParse(item["Sodium"].toString()), url: url,altUrl : altarnativeUrl,
                        )
                        ),

                         /*   "ID": 0,
                            "foodname": "Süt, bütün",
                            "Energy": 61,
                            "Carbohydrate": 4.7999,
                            "Protein": 3.1499,
                            "Total Fat": 3.25,
                            "Water": 88.1299,
                            "Sugars, total": 5.0499,
                            "Calcium": 113,
                            "Iron": 0.03,
                            "Magnesium": 10,
                            "Potassium": 132,
                            "Sodium": 43*/

                      );
                    },
                    child:
                        ListTile(
                        title: Text(item["foodname"]),
                        subtitle: Text('Kalorisi: ${item["Energy"]} kcal'),
                        ),
                  ),
                ),
              );
             }
            else {
              return SizedBox(height: 80,);
          }
          },

        ),
          if(isLoading)
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            )

        ],
      ),

    );
  }

  }

