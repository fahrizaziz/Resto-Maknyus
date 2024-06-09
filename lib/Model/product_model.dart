class ProductModel {
  String? status;
  List<DataProduct>? dataProduct;

  ProductModel({
    this.status,
    this.dataProduct,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      dataProduct = <DataProduct>[];
      json['data'].forEach((v) {
        dataProduct!.add(DataProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataProduct != null) {
      data['data'] = dataProduct!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class DataProduct {
  String? name, price, image;

  DataProduct({
    this.name,
    this.price,
    this.image,
  });

  DataProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
