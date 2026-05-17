import 'package:carpinteria_application/add_product_screen.dart';
import 'package:carpinteria_application/screens/product_detail_screen.dart';
import 'package:carpinteria_application/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:carpinteria_application/models/product.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<Product> filteredProducts = [];
  final productService = ProductService();
  List<Product> allProducts = [];

  //=====CARGAR PRODUCTOS DE LA CATEGORIA=======
  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    final loadedProducts = productService.loadProducts();
    allProducts = loadedProducts.where((product) {
      return product.category == widget.category;
    }).toList();
    filteredProducts = List.from(allProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos de la Categoría')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown.shade400, Colors.orange.shade300],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categoría',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //=======BUSCADOR=======
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.brown.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filteredProducts = allProducts.where((product) {
                    return product.name.toLowerCase().contains(
                      value.toLowerCase(),
                    );
                  }).toList();
                });
              },
            ),
            const SizedBox(height: 12),
            //=======CONTADOR=======
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredProducts.length} productos encontrados',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 18),

            filteredProducts.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 80,
                            color: Colors.brown.shade300,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'No hay productos en esta categoría',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              //=====NOMBRE======
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //=======VER DETALLE=======
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                        product: product,
                                        onDelete: () {
                                          setState(() {
                                            allProducts.removeWhere(
                                              (p) => p.id == product.id,
                                            );
                                            filteredProducts.removeWhere(
                                              (p) => p.id == product.id,
                                            );
                                            productService.deleteProduct(
                                              product.id,
                                            );
                                          });
                                        },
                                        onEdit: (updatedProduct) {
                                          final productIndex = allProducts
                                              .indexWhere(
                                                (p) => p.id == product.id,
                                              );
                                          if (productIndex != -1) {
                                            allProducts[productIndex] =
                                                updatedProduct;
                                          }
                                          filteredProducts = List.from(
                                            allProducts,
                                          );
                                          productService.updateProduct(
                                            updatedProduct,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Ver'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade300,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductScreen(
                selectedCategory: widget.category,
                onAddProduct: (newProduct) {
                  setState(() {
                    allProducts.add(newProduct);
                    filteredProducts = List.from(allProducts);
                  });
                  productService.addProduct(newProduct);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
