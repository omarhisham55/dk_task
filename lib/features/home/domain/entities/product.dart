class Product {
  final String id;
  final String name;
  final int size;
  final int feddans;
  final Map<String, dynamic>? img;

  Product({
    required this.id,
    required this.name,
    required this.size,
    required this.feddans,
    this.img,
  });
}
