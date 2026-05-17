import 'package:carpinteria_application/models/product.dart';
import 'package:hive/hive.dart';
import 'package:carpinteria_application/data/dummy_data.dart';

class ProductService {
  final Box<Product> box = Hive.box<Product>('products');

  //=======INICIALIZAR PRODUCTOS=======
  Future<void> initializeProducts() async {
    if (box.isEmpty){
      for (var product in products){
        await box.put(
          product.id,
          product,
        );
      }
    }
  }

  //=========LEER LISTA==========
  List<Product> loadProducts() {
    return box.values.toList();
  }

  //=======AGREGAR PRODUCTOS=======
  Future<void> addProduct(Product product) async {
    await box.put(
      product.id,
      product,
    );
  }

  //=========GUARDAR PRODUCTOS=========
  Future<void> saveProducts(List<Product> products) async {
    final box = Hive.box<Product>('products');
    await box.clear();
    for (var product in products){
      await box.put(
        product.id,
        product
      );
    }
  }

  //========ACTUALIZAR PRODUCTO=======
  Future<void> updateProduct(Product product) async {
    await box.put(
      product.id,
      product,
    );
  }

  //========ELIMINAR PRODUCTOS=======
  Future<void> deleteProduct(String id) async {
    await box.delete(id);
  }

}