import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beslenme/Pages/BesinDetay.dart';

class FoodsInfo extends StatefulWidget {
  @override
  _FoodsInfoState createState() => _FoodsInfoState();
}

class _FoodsInfoState extends State<FoodsInfo> {
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> filteredList = [];
  int itemCount = 0;
  bool isLoading = false;
  bool searching = false;
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
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ///Kullanıcı listenin sonuna ulaştı, daha fazla veri yükle
      loadData();
    }
  }

  Future<void> loadData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        itemCount += 100;
      });

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

  void filteredData(String query) {
    List<Map<String, dynamic>> tempList = [];
    tempList.addAll(dataList);
    if (query.isNotEmpty) {
      searching = true;
      tempList = tempList.where((item) {
        String foodName = item["foodname"].toString().toLowerCase();
        return foodName.contains(query.toLowerCase());
      }).toList();
    } else {
      searching = false;
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
          onChanged: (value) {
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
              onPressed: () {
                filteredData(_searchController.text);
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: searching ? filteredList.length + 1 : itemCount,
            itemBuilder: (context, index) {
              if (index < filteredList.length) {
                var item = filteredList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: (index % 2 == 0)
                                ? [Colors.green.withOpacity(0.4), Colors.green.withOpacity(0.6)]
                                : [Colors.green.withOpacity(0.6), Colors.green.withOpacity(0.4)]
                        )
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetails(
                              foodName: item["foodname"],
                              energy: double.tryParse(item["Energy"].toString()) ?? 0.0,
                              carbohydrate: double.tryParse(item["Carbohydrate"].toString()) ?? 0.0,
                              protein: double.tryParse(item["Protein"].toString()) ?? 0.0,
                              totalFat: double.tryParse(item["Total Fat"].toString()) ?? 0.0,
                              water: double.tryParse(item["Water"].toString()) ?? 0.0,
                              sugars: double.tryParse(item["Sugars"].toString()) ?? 0.0,
                              calcium: double.tryParse(item["Calcium"].toString()) ?? 0.0,
                              iron: double.tryParse(item["Iron"].toString()) ?? 0.0,
                              magnesium: double.tryParse(item["Magnesium"].toString()) ?? 0.0,
                              potassium: double.tryParse(item["Potassium"].toString()) ?? 0.0,
                              sodium: double.tryParse(item["Sodium"].toString()) ?? 0.0,
                              url: item["URL"] ?? '',
                              altUrl: item["alternative_url"] ?? '',
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(item["foodname"]),
                        subtitle: Text('Kalorisi: ${item["Energy"]} kcal'),
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(height: 80,);
              }
            },
          ),
          if (isLoading)
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
