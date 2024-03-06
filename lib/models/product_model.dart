class ProductModel {
  final int id;
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
    required this.id,
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

  ProductModel copyWith({
 int? id,
    String? name,
    String? size,
    DateTime? deliveryDate,
    double? price,
    String? discount,
    int? quantity,
    String? imageUrl,
    double? rating,
    int? ratedBy,
    String? meta,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        size: size ?? this.size,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        quantity: quantity ?? this.quantity,
        imageUrl: imageUrl ?? this.imageUrl,
        rating: rating ?? this.rating,
        ratedBy: ratedBy ?? this.ratedBy,
        meta: meta ?? this.meta,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
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
