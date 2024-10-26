class CarModel {
  String? id;
  String? name;
  String? model;
  int? price;

  CarModel({this.id, this.name, this.model, this.price});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    price = json['price']?.toInt();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'price': price,
    };
  }
}