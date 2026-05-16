import '../../domain/entities/categories.dart';

class CategoryModel extends Category {
  const CategoryModel({
    super.slug,
    super.name,
    super.url,
  }) : super();

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }
}