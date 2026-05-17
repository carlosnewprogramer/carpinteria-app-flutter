import 'package:hive/hive.dart';
import 'package:carpinteria_application/models/product.dart';

class HiveService {

  static final Box<Product>
      _productBox =
      Hive.box<Product>('products');

  //=====OBTENER=====
  static List<Product> getProducts() {
    return _productBox.values.toList();
  }

  //=====AGREGAR=====
  static Future<void> addProduct(
    Product product,
  ) async {

    await _productBox.put(
      product.id,
      product,
    );
  }

  //=====ELIMINAR=====
  static Future<void> deleteProduct(
    String id,
  ) async {
    await _productBox.delete(id);
  }
}