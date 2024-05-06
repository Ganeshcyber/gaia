// To parse this JSON data, do
//
//     final getIndentsList = getIndentsListFromJson(jsonString);

import 'dart:convert';

GetIndentsList getIndentsListFromJson(String str) => GetIndentsList.fromJson(json.decode(str));

String getIndentsListToJson(GetIndentsList data) => json.encode(data.toJson());

class GetIndentsList {
  int? count;
  List<GetIndentsData>? results;

  GetIndentsList({
    this.count,
    this.results,
  });

  factory GetIndentsList.fromJson(Map<String, dynamic> json) => GetIndentsList(
        count: json["count"],
        results: json["results"] == null ? [] : List<GetIndentsData>.from(json["results"]!.map((x) => GetIndentsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GetIndentsData {
  String? id;
  String? code;
  SalesAgent? salesAgent;
  Location? productType;
  GetIndentsDataRetailer? retailer;
  DateTime? date;
  DateTime? deliveryDate;
  String? description;
  IngAddress? billingAddress;
  IngAddress? shippingAddress;
  Location? location;
  int? noOfItems;
  String? total;
  String? discountPercent;
  String? discountAmount;
  String? gross;
  String? taxPercent;
  String? taxAmount;
  String? net;
  int? indentStatus;
  String? indentStatusName;
  String? createdOn;
  String? modifiedOn;
  List<RetailerOrderItem>? retailerOrderItems;

  GetIndentsData({
    this.id,
    this.code,
    this.salesAgent,
    this.productType,
    this.retailer,
    this.date,
    this.deliveryDate,
    this.description,
    this.billingAddress,
    this.shippingAddress,
    this.location,
    this.noOfItems,
    this.total,
    this.discountPercent,
    this.discountAmount,
    this.gross,
    this.taxPercent,
    this.taxAmount,
    this.net,
    this.indentStatus,
    this.indentStatusName,
    this.createdOn,
    this.modifiedOn,
    this.retailerOrderItems,
  });

  factory GetIndentsData.fromJson(Map<String, dynamic> json) => GetIndentsData(
        id: json["id"],
        code: json["code"],
        salesAgent: json["sales_agent"] == null ? null : SalesAgent.fromJson(json["sales_agent"]),
        productType: json["product_type"] == null ? null : Location.fromJson(json["product_type"]),
        retailer: json["retailer"] == null ? null : GetIndentsDataRetailer.fromJson(json["retailer"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
        description: json["description"],
        billingAddress: json["billing_address"] == null ? null : IngAddress.fromJson(json["billing_address"]),
        shippingAddress: json["shipping_address"] == null ? null : IngAddress.fromJson(json["shipping_address"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        noOfItems: json["no_of_items"],
        total: json["total"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        gross: json["gross"],
        taxPercent: json["tax_percent"],
        taxAmount: json["tax_amount"],
        net: json["net"],
        indentStatus: json["indent_status"],
        indentStatusName: json["indent_status_name"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
        retailerOrderItems: json["retailer_indent_items"] == null
            ? []
            : List<RetailerOrderItem>.from(json["retailer_indent_items"]!.map((x) => RetailerOrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "sales_agent": salesAgent?.toJson(),
        "product_type": productType?.toJson(),
        "retailer": retailer?.toJson(),
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "billing_address": billingAddress?.toJson(),
        "shipping_address": shippingAddress?.toJson(),
        "location": location?.toJson(),
        "no_of_items": noOfItems,
        "total": total,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "gross": gross,
        "tax_percent": taxPercent,
        "tax_amount": taxAmount,
        "net": net,
        "indent_status": indentStatus,
        "indent_status_name": indentStatusName,
        "created_on": createdOn,
        "modified_on": modifiedOn,
        "retailer_indent_items": retailerOrderItems == null ? [] : List<dynamic>.from(retailerOrderItems!.map((x) => x.toJson())),
      };
}

class IngAddress {
  String? id;
  String? code;
  BillingAddressRetailer? retailer;
  dynamic name;
  String? phone;
  dynamic alternatePhone;
  String? dNo;
  Location? area;
  Location? city;
  Location? state;
  String? landmark;
  String? pincode;

  IngAddress({
    this.id,
    this.code,
    this.retailer,
    this.name,
    this.phone,
    this.alternatePhone,
    this.dNo,
    this.area,
    this.city,
    this.state,
    this.landmark,
    this.pincode,
  });

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
        id: json["id"],
        code: json["code"],
        retailer: json["retailer"] == null ? null : BillingAddressRetailer.fromJson(json["retailer"]),
        name: json["name"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        dNo: json["d_no"],
        area: json["area"] == null ? null : Location.fromJson(json["area"]),
        city: json["city"] == null ? null : Location.fromJson(json["city"]),
        state: json["state"] == null ? null : Location.fromJson(json["state"]),
        landmark: json["landmark"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "retailer": retailer?.toJson(),
        "name": name,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "d_no": dNo,
        "area": area?.toJson(),
        "city": city?.toJson(),
        "state": state?.toJson(),
        "landmark": landmark,
        "pincode": pincode,
      };
}

class Location {
  String? id;
  String? name;

  Location({
    this.id,
    this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class BillingAddressRetailer {
  String? id;
  String? firstName;
  String? phone;

  BillingAddressRetailer({
    this.id,
    this.firstName,
    this.phone,
  });

  factory BillingAddressRetailer.fromJson(Map<String, dynamic> json) => BillingAddressRetailer(
        id: json["id"],
        firstName: json["first_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "phone": phone,
      };
}

class GetIndentsDataRetailer {
  String? id;
  String? fullname;
  String? phone;
  Location? location;
  IngAddress? defaultBillingAddress;
  IngAddress? defaultShippingAddress;
  SalesAgent? salesagent;
  SalesAgent? distributor;

  GetIndentsDataRetailer({
    this.id,
    this.fullname,
    this.phone,
    this.location,
    this.defaultBillingAddress,
    this.defaultShippingAddress,
    this.salesagent,
    this.distributor,
  });

  factory GetIndentsDataRetailer.fromJson(Map<String, dynamic> json) => GetIndentsDataRetailer(
        id: json["id"],
        fullname: json["fullname"],
        phone: json["phone"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        defaultBillingAddress: json["default_billing_address"] == null ? null : IngAddress.fromJson(json["default_billing_address"]),
        defaultShippingAddress: json["default_shipping_address"] == null ? null : IngAddress.fromJson(json["default_shipping_address"]),
        salesagent: json["salesagent"] == null ? null : SalesAgent.fromJson(json["salesagent"]),
        distributor: json["distributor"] == null ? null : SalesAgent.fromJson(json["distributor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone": phone,
        "location": location?.toJson(),
        "default_billing_address": defaultBillingAddress?.toJson(),
        "default_shipping_address": defaultShippingAddress?.toJson(),
        "salesagent": salesagent?.toJson(),
        "distributor": distributor?.toJson(),
      };
}

class SalesAgent {
  String? id;
  String? fullname;
  String? username;

  SalesAgent({
    this.id,
    this.fullname,
    this.username,
  });

  factory SalesAgent.fromJson(Map<String, dynamic> json) => SalesAgent(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
      };
}

class RetailerOrderItem {
  String? id;
  String? code;
  dynamic date;
  Location? location;
  Product? product;
  String? quantity;
  String? requestedQuantity;
  Location? unit;
  int? freeQuantity;
  int? reqFreeQuantity;
  String? price;
  String? discountPercent;
  String? discountAmount;
  String? taxPercent;
  String? createdOn;
  String? modifiedOn;

  RetailerOrderItem({
    this.id,
    this.code,
    this.date,
    this.location,
    this.product,
    this.quantity,
    this.requestedQuantity,
    this.unit,
    this.freeQuantity,
    this.reqFreeQuantity,
    this.price,
    this.discountPercent,
    this.discountAmount,
    this.taxPercent,
    this.createdOn,
    this.modifiedOn,
  });

  factory RetailerOrderItem.fromJson(Map<String, dynamic> json) => RetailerOrderItem(
        id: json["id"],
        code: json["code"],
        date: json["date"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        requestedQuantity: json["requested_quantity"],
        unit: json["unit"] == null ? null : Location.fromJson(json["unit"]),
        freeQuantity: json["free_quantity"],
        reqFreeQuantity: json["req_free_quantity"],
        price: json["price"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        taxPercent: json["tax_percent"],
        createdOn: json["created_on"],
        modifiedOn: json["modified_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "date": date,
        "location": location?.toJson(),
        "product": product?.toJson(),
        "quantity": quantity,
        "requested_quantity": requestedQuantity,
        "unit": unit?.toJson(),
        "free_quantity": freeQuantity,
        "req_free_quantity": reqFreeQuantity,
        "price": price,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "tax_percent": taxPercent,
        "created_on": createdOn,
        "modified_on": modifiedOn,
      };
}

class Product {
  String? id;
  String? name;
  String? category;
  String? image;

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
