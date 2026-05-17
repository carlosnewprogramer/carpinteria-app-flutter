import 'package:carpinteria_application/models/product.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Product) onAddProduct;
  final Product? product;
  final String selectedCategory;

  const AddProductScreen({
    super.key,
    required this.onAddProduct,
    required this.selectedCategory,
    this.product,

  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState(); 
}

class _AddProductScreenState extends State<AddProductScreen> {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    File? selectedImage;

    final List<String> categories = [
      'Juegos de sala',
      'Comedores',
      'Juegos de alcoba',
      'Puertras',
      'Ventanas',
    ];

    String selectedCategory = 'Juegos de sala';

    @override
    void initState(){
      super.initState();
      if (widget.product != null){
        nameController.text = widget.product!.name;
        priceController.text = widget.product!.price.toString();
        stockController.text = widget.product!.stock.toString();
        selectedCategory = widget.product?.category ?? widget.selectedCategory;
      }
    }

    void saveProduct(){
      final product = Product(
        id: widget.product?.id ?? DateTime.now().toString(),
        name: nameController.text,
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        imageUrl: selectedImage?.path ?? '',
        category: widget.selectedCategory,
      );
      widget.onAddProduct(product);
      Navigator.pop(context);
    }

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null){
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: selectedImage != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text('Seleccionar imagen'),
                  ],
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.chair),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Precio',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.chair),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: stockController,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.chair),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: saveProduct,
                child: const Text('Guardar Producto',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}