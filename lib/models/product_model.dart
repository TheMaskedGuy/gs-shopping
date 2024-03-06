class ProductModel {
  final String? name;
  final String? size;
  final DateTime? deliveryDate;
  final double? price;
  final String? discount;
  final int? quantity;
  final String? imageUrl;
  final double? rating;
  final int? ratedBy;
  final String? meta;

  ProductModel({
    this.name,
    this.meta,
    this.size,
    this.deliveryDate,
    this.price,
    this.discount,
    this.quantity,
    this.imageUrl,
    this.rating,
    this.ratedBy,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      name: json["name"],
      meta: json['meta'],
      size: json["size"],
      deliveryDate: DateTime.fromMillisecondsSinceEpoch(json["deliveryDate"]),
      price: json["price"],
      discount: json["discount"],
      quantity: json["quantity"],
      imageUrl: json["imageUrl"],
      rating: json['rating'],
      ratedBy: json['rated_by']);

  // Map<String, dynamic> toJson() => {
  //     "name": name,
  //     "size": size,
  //     "deliveryDate": deliveryDate,
  //     "price": price,
  //     "discount": discount,
  //     "quantity": quantity,
  //     "imageUrl": imageUrl,
  // };
}
