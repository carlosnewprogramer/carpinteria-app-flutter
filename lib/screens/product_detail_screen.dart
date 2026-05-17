import 'package:carpinteria_application/add_product_screen.dart';
import 'package:carpinteria_application/models/product.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final Function(Product) onEdit;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //========IMAGEN========
            SizedBox(
              width: double.infinity,
              height: 320,
              child: product.imageUrl.isNotEmpty
                  ? Image.file(File(product.imageUrl), fit: BoxFit.cover)
                  : Container(
                      color: Colors.brown.shade100,
                      child: const Icon(
                        Icons.chair,
                        size: 120,
                        color: Colors.brown,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //=====NOMBRE=====
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  //=====CATEGORIA=====
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category,
                      style: const TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  //=====PRECIO=====
                  Text(
                    'Precio: \$${product.price}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  //=====STOCK=====
                  Text(
                    'Stock disponible: ${product.stock}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      //=======EDITAR=======
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddProductScreen(
                                  product: product,
                                  onAddProduct: (updatedProduct){
                                    onEdit(updatedProduct);
                                  }, selectedCategory: '',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Editar'),
                        ),
                      ),
                      const SizedBox(width: 14),
                      //========ELIMINAR========
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          onPressed: (){
                            onDelete();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Eliminar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
