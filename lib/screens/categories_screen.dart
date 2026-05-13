import 'package:carpinteria_application/data/dummy_data.dart';
import 'package:carpinteria_application/screens/category_products_screen.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen ({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState(); 
}

class _CategoriesScreenState extends State<CategoriesScreen>{

  List<Map<String, dynamic>> 
    categories = [
      {'name': 'Juegos de Sala',
        'icon': Icons.weekend,
      },

      {'name': 'Juegos de Comedor',
        'icon': Icons.table_restaurant,
      },

      {'name': 'Juegos de Alcoba',
        'icon': Icons.bed,
      },

      {'name': 'Puertas',
        'icon': Icons.door_front_door,
      },

      {'name': 'Ventanas',
        'icon': Icons.window,
      },
    ];

  void addCategory(String name){
    setState(() {
      categories.add({
        'name': name,
        'icon': Icons.category,
      });
    });
  }

  void deleteCategory(int index){
    setState(() {
      categories.removeAt(index);
    });
  }

  void editCategory(int index, String newName){
    setState(() {
      categories[index]['name'] = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFBCAAA4),
        child: const Icon(
          Icons.add,
          color: Color(0xFF4E342E),
        ),
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
            context: context,
            builder: (_){
              return AlertDialog(
                title: const Text('Nueva categoría'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Nombre categoría',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(controller.text.trim().isEmpty){
                        return;
                      }
                      addCategory(controller.text.trim());
                      Navigator.pop(context);
                    }, 
                    child: const Text('Guardar'),
                  ),
                ],
              );
            },
          );
        },
      ),
      backgroundColor: const Color(0xFFF5F1EC),
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.90,
          ),
          itemBuilder: (context, index){
            final category = categories[index];
            return GestureDetector(
              onLongPress: (){
                showModalBottomSheet(
                  context: context,
                  builder: (_){
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Editar categoría'),
                            onTap: (){
                              Navigator.pop(context);
                              final controller = TextEditingController(
                                text: category['name'],
                              );
                              showDialog(
                                context: context,
                                builder: (_){
                                  return AlertDialog(
                                    title: const Text('Editar categoría'),
                                    content: TextField(
                                      controller: controller,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, 
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          editCategory(index, controller.text);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Guardar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.delete,
                              color: Colors.red,                             
                            ),
                            title: const Text('Eliminar Categoría'),
                            onTap: (){
                              final categoryName = category['name'];
                              final hasProducts = products.any((product){
                                return product.category == categoryName;
                              });
                              //=====SI TIENE PRODUCTOS======
                              if (hasProducts){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No puedes eliminar una categoría con productos asociados'),
                                  ),
                                );
                                return;
                              }
                              //=======CONFIRMACION========
                              showDialog(
                                context: context,
                                builder: (_){
                                  return AlertDialog(
                                    title: const Text('Eliminar categoría'),
                                    content: Text(
                                      'Deseas eliminar la categoria: "$categoryName"?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: (){
                                          deleteCategory(index);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  );                                  
                                },
                              );  
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryProductsScreen(
                      category: category['name'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFA1887F),
                      const Color(0xFFD7CCC8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                            category: categories[index]['name'],
                          ),
                        ),
                      );
                    },                
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              categories[index]['icon'],
                              size: 42,
                              color: const Color(0xFF5D4037),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            categories[index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4E342E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            );
          },  
        ),
      ),  
    );
  }
}