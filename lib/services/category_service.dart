import 'package:hive/hive.dart';

class CategoryService{
  final Box box = Hive.box('categories');

  //=======LEER CATEGORIAS=======
  List<String> loadCategories() {
    final data =
        box.get('category_list');

    if (data == null){
      return [];
    }
    return List<String>.from(data);
  }

  //======= GUARDAR CATEGORIA=======
  Future<void> saveCategories(
    List<String> categories,
  ) async {

    await box.put(
      'category_list',
      categories,
    );
  }

}