class ProductModel {
    final String? name;
    final String? size;
    final DateTime? deliveryDate;
    final double? price;
    final String? discount;
    final int? quantity;
    final String? imageUrl;

    ProductModel({
        this.name,
        this.size,
        this.deliveryDate,
        this.price,
        this.discount,
        this.quantity,
        this.imageUrl,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        size: json["size"],
        deliveryDate: DateTime.fromMillisecondsSinceEpoch(json["deliveryDate"]),
        price: json["price"],
        discount: json["discount"],
        quantity: json["quantity"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "size": size,
        "deliveryDate": deliveryDate,
        "price": price,
        "discount": discount,
        "quantity": quantity,
        "imageUrl": imageUrl,
    };
}
