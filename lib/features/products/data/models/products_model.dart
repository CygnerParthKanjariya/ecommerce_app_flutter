import '../../domain/entities/products.dart';

class ProductsModel extends Products {
  const ProductsModel({
    super.id,
    super.title,
    super.description,
    super.category,
    super.price,
    super.discountPercentage,
    super.rating,
    super.stock,
    super.tags,
    super.brand,
    super.sku,
    super.weight,
    super.dimensions,
    super.warrantyInformation,
    super.shippingInformation,
    super.availabilityStatus,
    super.reviews,
    super.returnPolicy,
    super.minimumOrderQuantity,
    super.meta,
    super.images,
    super.thumbnail,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      stock: json['stock'] as int?,
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList(),
      brand: json['brand'] as String?,
      sku: json['sku'] as String?,
      weight: json['weight'] as int?,
      dimensions: json['dimensions'] != null
          ? DimensionsModel.fromJson(json['dimensions'] as Map<String, dynamic>)
          : null,
      warrantyInformation: json['warrantyInformation'] as String?,
      shippingInformation: json['shippingInformation'] as String?,
      availabilityStatus: json['availabilityStatus'] as String?,
      reviews: (json['reviews'] as List?)
          ?.map((e) => ReviewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnPolicy: json['returnPolicy'] as String?,
      minimumOrderQuantity: json['minimumOrderQuantity'] as int?,
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>) : null,
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      thumbnail: json['thumbnail'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions != null ? (dimensions as DimensionsModel).toJson() : null,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews?.map((e) => (e as ReviewsModel).toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta != null ? (meta as MetaModel).toJson() : null,
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

class DimensionsModel extends Dimensions {
  const DimensionsModel({super.width, super.height, super.depth});

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }
}

class ReviewsModel extends Reviews {
  const ReviewsModel({super.rating, super.comment, super.date, super.reviewerName, super.reviewerEmail});

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      date: json['date'] as String?,
      reviewerName: json['reviewerName'] as String?,
      reviewerEmail: json['reviewerEmail'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class MetaModel extends Meta {
  const MetaModel({super.createdAt, super.updatedAt, super.barcode, super.qrCode});

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      barcode: json['barcode'] as String?,
      qrCode: json['qrCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'createdAt': createdAt, 'updatedAt': updatedAt, 'barcode': barcode, 'qrCode': qrCode};
  }
}
