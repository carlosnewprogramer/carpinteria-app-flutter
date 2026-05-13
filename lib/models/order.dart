import 'package:carpinteria_application/models/client.dart';
import 'package:carpinteria_application/models/product.dart';

class Order{
  final String id;
  final Client client;
  final List<Product> products;
  final double total;
  final DateTime date;
  final String status;

  Order({
    required this.id,
    required this.client,
    required this.products,
    required this.total,
    required this.date,
    required this.status,
  });
}