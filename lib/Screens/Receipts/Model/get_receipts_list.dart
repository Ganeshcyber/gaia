// To parse this JSON data, do
//
//     final getReceiptsList = getReceiptsListFromJson(jsonString);

import 'dart:convert';

import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';

GetReceiptsList getReceiptsListFromJson(String str) => GetReceiptsList.fromJson(json.decode(str));

String getReceiptsListToJson(GetReceiptsList data) => json.encode(data.toJson());

class GetReceiptsList {
  int? count;
  List<GetReceiptsData>? results;

  GetReceiptsList({
    this.count,
    this.results,
  });

  factory GetReceiptsList.fromJson(Map<String, dynamic> json) => GetReceiptsList(
        count: json["count"],
        results: json["results"] == null ? [] : List<GetReceiptsData>.from(json["results"]!.map((x) => GetReceiptsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GetReceiptsData {
  String? id;
  String? code;
  GetRetailersData? retailer;
  MiniProductTypeData? productType;
  int? noOfItems;
  String? total;
  String? discountPercent;
  String? discountAmount;
  String? taxPercent;
  String? taxAmount;
  String? net;
  String? createdOn;
  String? modifiedOn;
  List<ReceiptItem>? receiptItems;

  GetReceiptsData({
    this.id,
    this.code,
    this.retailer,
    this.productType,
    this.noOfItems,
    this.total,
    this.discountPercent,
    this.discountAmount,
    this.taxPercent,
    this.taxAmount,
    this.net,
    this.createdOn,
    this.modifiedOn,
    this.receiptItems,
  });

  factory GetReceiptsData.fromJson(Map<String, dynamic> json) => GetReceiptsData(
        id: json["id"],
        code: json["code"],
        retailer: json["retailer"] == null ? null : GetRetailersData.fromJson(json["retailer"]),
        productType: json["product_type"] == null ? null : MiniProductTypeData.fromJson(json["product_type"]),
        noOfItems: json["no_of_items"],
        total: json["total"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        taxPercent: json["tax_percent"],
        taxAmount: json["tax_amount"],
        net: json["net"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
        receiptItems: json["receipt_items"] == null ? [] : List<ReceiptItem>.from(json["receipt_items"]!.map((x) => ReceiptItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "retailer": retailer?.toJson(),
        "product_type": productType?.toJson(),
        "no_of_items": noOfItems,
        "total": total,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "tax_percent": taxPercent,
        "tax_amount": taxAmount,
        "net": net,
        "created_on": createdOn,
        "modified_on": modifiedOn,
        "receipt_items": receiptItems == null ? [] : List<dynamic>.from(receiptItems!.map((x) => x.toJson())),
      };
}

class ReceiptItem {
  String? id;
  String? code;
  Product? product;
  MiniUnitsData? unit;
  String? receivedQty;
  String? price;
  String? total;
  String? discountPercent;
  String? discountAmount;
  String? taxPercent;
  String? taxAmount;
  String? net;

  ReceiptItem({
    this.id,
    this.code,
    this.product,
    this.unit,
    this.receivedQty,
    this.price,
    this.total,
    this.discountPercent,
    this.discountAmount,
    this.taxPercent,
    this.taxAmount,
    this.net,
  });

  factory ReceiptItem.fromJson(Map<String, dynamic> json) => ReceiptItem(
        id: json["id"],
        code: json["code"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        unit: json["unit"] == null ? null : MiniUnitsData.fromJson(json["unit"]),
        receivedQty: json["received_qty"],
        price: json["price"],
        total: json["total"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        taxPercent: json["tax_percent"],
        taxAmount: json["tax_amount"],
        net: json["net"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "product": product?.toJson(),
        "unit": unit?.toJson(),
        "received_qty": receivedQty,
        "price": price,
        "total": total,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "tax_percent": taxPercent,
        "tax_amount": taxAmount,
        "net": net,
      };
}

class Product {
  String? id;
  String? name;
  String? category;
  dynamic image;

  Product({
    this.id,
    this.name,
    this.category,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "image": image,
      };
}
