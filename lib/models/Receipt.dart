import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ReceiptDto {
  final int id;
  final String? ourReference;
  final String? isProcessing;
  final String? failureReason;
  final DateTime? createdAt;
  final String? initiator;
  final ReceiptData? receiptData;

  ReceiptDto({
    required this.id,
    required this.ourReference,
    required this.isProcessing,
    required this.failureReason,
    required this.createdAt,
    required this.initiator,
    required this.receiptData,
  });

  factory ReceiptDto.fromJson(Map<String, dynamic> json) {
    return ReceiptDto(
        id: json['id'] as int,
        ourReference: json['ourReference'] as String?,
        isProcessing: json['isProcessing'] as String?,
        failureReason: json['failureReason'] as String?,
        createdAt: (json['createdAt'] != null)
            ? DateTime.parse(json['createdAt'] as String).toLocal()
            : null,
        initiator: json['initiator'] as String?,
        receiptData: (json['receiptData'] != null)
            ? ReceiptData.fromJson(json['receiptData'] as Map<String, dynamic>)
            : null);
  }
  @override
  String toString() {
    return 'ReceiptDto{id: $id, ourReference: $ourReference, isProcessing: $isProcessing, '
        'failureReason: $failureReason, createdAt: $createdAt, initiator: $initiator, '
        'receiptData: $receiptData}';
  }
}

@JsonSerializable(explicitToJson: true)
class ReceiptData {
  final int id;
  final String? referenceNumber;
  final String? imgTumbUrl;
  final String? deliveryDate;
  final double? discount;
  final double? subtotal;
  final double? total;
  final String? vendorName;
  final List<ReceiptItem>? lineItems;

  ReceiptData({
    required this.id,
    required this.referenceNumber,
    required this.imgTumbUrl,
    required this.deliveryDate,
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.vendorName,
    required this.lineItems,
  });

  factory ReceiptData.fromJson(Map<String, dynamic> json) {
    return ReceiptData(
      id: json['id'] as int,
      referenceNumber: json['referenceNumber'] as String?,
      imgTumbUrl: json['imgTumbUrl'] as String?,
      deliveryDate: json['deliveryDate'] as String?,
      discount: (json['discount'] as double?),
      subtotal: (json['subtotal'] as double?),
      total: (json['total'] as double?),
      vendorName: json['vendorName'] as String?,
      lineItems: (json['lineItems'] != null)
          ? (json['lineItems'] as List<dynamic>)
              .map((e) => ReceiptItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
  @override
  String toString() {
    return 'ReceiptData{id: $id, referenceNumber: $referenceNumber, imgTumbUrl: $imgTumbUrl, '
        'deliveryDate: $deliveryDate, discount: $discount, subtotal: $subtotal, '
        'total: $total, vendorName: $vendorName, lineItems: $lineItems}';
  }
}

@JsonSerializable()
class ReceiptItem {
  final int id;
  final String? description;
  final double? discount;
  final double? total;
  final String? fullDescription;
  final String? text;
  final double? quantity;
  final double? weight;
  final double? tax;

  ReceiptItem({
    required this.id,
    required this.description,
    required this.discount,
    required this.total,
    required this.fullDescription,
    required this.text,
    required this.quantity,
    required this.weight,
    required this.tax,
  });

  factory ReceiptItem.fromJson(Map<String, dynamic> json) {
    return ReceiptItem(
      id: json['id'] as int,
      description: json['description'] as String?,
      discount: (json['discount'] as double?),
      total: (json['total'] as double?),
      fullDescription: json['fullDescription'] as String?,
      text: json['text'] as String?,
      quantity: (json['quantity'] as double?),
      weight: (json['weight'] as double?),
      tax: (json['tax'] as double?),
    );
  }
  @override
  String toString() {
    return 'ReceiptItem{id: $id, description: $description, discount: $discount, '
        'total: $total, fullDescription: $fullDescription, text: $text, '
        'quantity: $quantity, weight: $weight, tax: $tax}';
  }
}
