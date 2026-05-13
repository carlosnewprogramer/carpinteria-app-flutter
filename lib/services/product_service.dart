import 'package:carpinteria_application/models/product.dart';
import 'package:hive/hive.dart';

class ProductService {
  final Box box = Hive.box('products');

  //=========GUARDAR=========
  void saveProducts(List<Product> products){
    final productMaps = products.map((product){
      return {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'stock': product.stock,
        'imageUrl': product.imageUrl,
        'category': product.category,
      };
    }).toList();
    box.put('product_list', productMaps);
  }
  //=========LEER LISTA==========
  List<Product> loadProducts(){
    final data = box.get('product_list');
    if (data == null) return [];
    return List<Map>.from(data).map((item){
      return Product(
        id: item['id'],
        name: item['name'],
        price: item['price'],
        stock: item['stock'],
        imageUrl: item['imageUrl'],
        category: item['category'],
      );
    }).toList();
  }
}