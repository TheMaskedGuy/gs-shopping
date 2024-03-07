class UserModel {
  final String? name;
  final String? url;
  final List<OrderModel>? orders;

  UserModel({
    this.name,
    this.url,
    this.orders,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        url: json["url"],
        orders: json["orders"] == null
            ? []
            : List<OrderModel>.from(
                json["orders"]!.map((x) => OrderModel.fromJson(x))),
      );
}

class OrderModel {
  final int? id;
  final int? productId;
  final String? status;

  OrderModel({
    this.id,
    this.productId,
    this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        productId: json["productId"],
        status: json["status"],
      );
}
