import 'package:flutter/material.dart';
import 'package:carpinteria_application/add_product_screen.dart';
import 'package:carpinteria_application/data/dummy_data.dart';
import 'package:carpinteria_application/models/product.dart';
import 'package:carpinteria_application/widgets/product_card.dart';
import 'package:carpinteria_application/services/product_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Product> productList;
  late List<Product> filteredProducts;
  final productService = ProductService();

  @override
  void initState() {
    super.initState();
    productList = productService.loadProducts();
    if (productList.isEmpty){
      productList = List.from(products);
    }
    filteredProducts = productList;
  }

  void updateProduct(Product updateProduct){
    final index = productList.indexWhere(
        (product) => product.id == updateProduct.id,
      );
    setState(() {
      productList[index] = updateProduct;
      filteredProducts = productList; 
    });
    productService.saveProducts(productList);
  }

  void deleteProduct(String id){
    setState(() {
      productList.removeWhere(
        (product) => product.id == id,
      );
      filteredProducts = productList;
    });
    productService.saveProducts(productList);
  }

  void searchProduct(String query){
    setState(() {
      filteredProducts = productList.where(
        (product){
          return product.name.toLowerCase()
          .contains(query.toLowerCase());
        }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //==========SEARCH BAR========
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: searchProduct,
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Buscar producto...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.brown,  
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      color: Colors.brown,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            //=========RESULTADOS=========
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredProducts.length} productos encontrados',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 15),
            //=========LISTA=========
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index){
                  final product = filteredProducts[index];

                  return ProductCard(
                    product: product,
                    onEdit: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (_) => AddProductScreen(
                            product: product,
                            onAddProduct: (updatedProduct) {
                              updateProduct(updatedProduct);
                            },
                          ),
                        ),
                      );
                    },
                    onDelete: (){
                      deleteProduct(product.id);
                    },
                  );
                },
              ),
            ),
          ],  
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.brown.shade300,
        onPressed: (){
          Navigator.push(
            context, 
              MaterialPageRoute(
                builder: (_) => AddProductScreen(
                  onAddProduct: (newProduct) {
                    setState(() {
                      productList.add(newProduct);
                      filteredProducts = productList;
                    });
                    productService.saveProducts(productList);
                  },
                ),
              ),
          );  
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),        
    );
  }
}