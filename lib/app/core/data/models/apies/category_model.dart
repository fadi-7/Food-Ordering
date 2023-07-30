import 'meal_model.dart';

class CategoryModel {
  int? id;
  String? name;
  String? logo;
  List<MealModel>? meals;

  CategoryModel({this.id, this.name, this.logo, this.meals});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    if (json['meals'] != null) {
      meals = <MealModel>[];
      json['meals'].forEach((v) {
        meals!.add(new MealModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
