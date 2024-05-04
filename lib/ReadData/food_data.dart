class FoodData {
  final String Id;
  final int foodName;

  FoodData({required this.Id, required this.foodName});

  factory FoodData.fromJson(Map<String, dynamic> json) {
    return FoodData(
      Id: json['ID'],
      foodName: json['foodName'],
    );
  }
}
