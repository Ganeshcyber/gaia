// To parse this JSON data, do
//
//     final postRetailerIndentModel = postRetailerIndentModelFromJson(jsonString);

import 'dart:convert';

PostRetailerIndentModel postRetailerIndentModelFromJson(String str) => PostRetailerIndentModel.fromJson(json.decode(str));

String postRetailerIndentModelToJson(PostRetailerIndentModel data) => json.encode(data.toJson());

class PostRetailerIndentModel {
  String? salesAgentId;
  String? producttypeId;
  String? retailerId;
  DateTime? date;
  DateTime? deliveryDate;
  String? description;
  String? billingAddressId;
  String? locationId;
  String? discountPercent;
  String? taxPercent;
  List<RetailerIndentItem>? retailerIndentItems;

  PostRetailerIndentModel({
    this.salesAgentId,
    this.producttypeId,
    this.retailerId,
    this.date,
    this.deliveryDate,
    this.description,
    this.billingAddressId,
    this.locationId,
    this.discountPercent,
    this.taxPercent,
    this.retailerIndentItems,
  });

  factory PostRetailerIndentModel.fromJson(Map<String, dynamic> json) => PostRetailerIndentModel(
        salesAgentId: json["sales_agent_id"],
        producttypeId: json["producttype_id"],
        retailerId: json["retailer_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
        description: json["description"],
        billingAddressId: json["billing_address_id"],
        locationId: json["location_id"],
        discountPercent: json["discount_percent"],
        taxPercent: json["tax_percent"],
        retailerIndentItems: json["retailer_indent_items"] == null
            ? []
            : List<RetailerIndentItem>.from(json["retailer_indent_items"]!.map((x) => RetailerIndentItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sales_agent_id": salesAgentId,
        "producttype_id": producttypeId,
        "retailer_id": retailerId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "billing_address_id": billingAddressId,
        "location_id": locationId,
        "discount_percent": discountPercent,
        "tax_percent": taxPercent,
        "retailer_indent_items": retailerIndentItems == null ? [] : List<dynamic>.from(retailerIndentItems!.map((x) => x.toJson())),
      };
}

class RetailerIndentItem {
  String? locationId;
  String? productId;
  String? quantity;
  String? requestedQuantity;
  String? unitId;
  int? originalQuantity;
  int? freeQuantity;
  int? reqFreeQuantity;
  String? discountPercent;
  String? discountAmount;
  String? taxPercent;
  String? taxAmount;

  RetailerIndentItem({
    this.locationId,
    this.productId,
    this.quantity,
    this.requestedQuantity,
    this.unitId,
    this.originalQuantity,
    this.freeQuantity,
    this.reqFreeQuantity,
    this.discountPercent,
    this.discountAmount,
    this.taxPercent,
    this.taxAmount,
  });

  factory RetailerIndentItem.fromJson(Map<String, dynamic> json) => RetailerIndentItem(
        locationId: json["location_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        requestedQuantity: json["requested_quantity"],
        unitId: json["unit_id"],
        originalQuantity: json["original_quantity"],
        freeQuantity: json["free_quantity"],
        reqFreeQuantity: json["req_free_quantity"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        taxPercent: json["tax_percent"],
        taxAmount: json["tax_amount"],
      );

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "product_id": productId,
        "quantity": quantity,
        "requested_quantity": requestedQuantity,
        "unit_id": unitId,
        "original_quantity": originalQuantity,
        "free_quantity": freeQuantity,
        "req_free_quantity": reqFreeQuantity,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "tax_percent": taxPercent,
        "tax_amount": taxAmount,
      };
}
