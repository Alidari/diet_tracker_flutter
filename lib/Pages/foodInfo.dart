import 'dart:convert';
import 'package:beslenme/Pages/BesinDetay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodsInfo extends StatefulWidget {
  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<FoodsInfo> {
  List<Map<String,dynamic>> dataList = [];
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
    print("Before: " + isLoading.toString());

    if(!isLoading) {
      setState(() {
        isLoading = true;
        itemCount+=100;
      });
      print("After: " + isLoading.toString());

      String jsonData = await rootBundle.loadString('assets/data.json');
      List<dynamic> jsonList = json.decode(jsonData);

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

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodDetails(
                            foodName: item["foodname"], energy: double.tryParse(item["_208 Energy (kcal)"].toString()), carbohydrate: double.tryParse(item["_205 Carbohydrate (g)"].toString()),
                            protein: double.tryParse(item["_203 Protein (g)"].toString()), totalFat: double.tryParse(item["_204 Total Fat (g)"].toString()), water: double.tryParse(item["_255 Water (g)"].toString()),
                            sugars: double.tryParse(item["_269 Sugars, total (g)"].toString()), calcium: double.tryParse(item["301 Calcium (mg)"].toString()), iron: double.tryParse(item["_303 Iron (mg)"].toString()),
                            magnesium: double.tryParse(item["_304 Magnesium (mg)"].toString()), potassium: double.tryParse(item["_306 Potassium (mg)"].toString()), sodium: double.tryParse(item["_307 Sodium (mg)"].toString())
                        )
                        ),

                         /* "\"ID\"": 1,
                          "foodname": "Süt, bütün, düşük sodyumlu",
                          "_208 Energy (kcal)": 61,
                          "_205 Carbohydrate (g)": 4.4599,
                          "_203 Protein (g)": 3.1,
                          "_204 Total Fat (g)": 3.4599,
                          "_255 Water (g)": 88.2,
                          "_269 Sugars, total (g)": 4.4599,
                          "_301 Calcium (mg)": 101,
                          "_303 Iron (mg)": 0.05,
                          "_304 Magnesium (mg)": 5,
                          "_306 Potassium (mg)": 253,
                          "_307 Sodium (mg)": 3*/

                      );
                    },
                    child:
                        ListTile(
                        title: Text(item["foodname"]),
                        subtitle: Text('Kalorisi: ${item["_208 Energy (kcal)"]}'),
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

