import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:uuid/uuid.dart';

//CAtegory Controllers are given below
ValueNotifier<List<CategoryModel>> categoryListNotifier = ValueNotifier([]);

Future<void> getAllCategories() async {
  final box1 = await Hive.openBox<CategoryModel>('product_db');
  categoryListNotifier.value.clear();
  categoryListNotifier.value.addAll(box1.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  categoryListNotifier.notifyListeners();
  print('All Categories are listed');
}

// Function to delete a category in Hive


// Function to update a category in Hive
Future<void> updateCategory(CategoryModel updatedCategory) async {
  try {
    var box1 = await Hive.openBox<CategoryModel>('product_db');
    int index =
        box1.values.toList().indexWhere((cat) => cat.id == updatedCategory.id);
    if (index != -1) {
      box1.putAt(index, updatedCategory);
    } else {
      throw 'Category not found';
    } // Notify listeners after updating
  } catch (error) {
    print('Failed to update category: $error');
    throw 'Failed to update category: $error';
  }
  getAllCategories();
}

//Future<void> addCategory(CategoryModel categories) async {
//  final box1 = await Hive.openBox<CategoryModel>('product_db');
//  await box1.add(categories);
//  getAllCategories();
//}

Future<void> addCategory(CategoryModel category) async {
  final box1 = await Hive.openBox<CategoryModel>('product_db');
  const uuid = Uuid();
  final uuidString = uuid.v4(); // Generate UUID as a string
  final id = uuidString.hashCode.abs(); // Convert UUID string to integer
  category.id = id;
  await box1.add(category);

  getAllCategories();
} 

Future<void> deleteCategory(int id) async {
  try {
    final box1 = await Hive.openBox<CategoryModel>('product_db');
      await box1.delete(id);
      print('Category with ID $id deleted successfully.');
      categoryListNotifier.value.clear();
      
    await box1.close();
  } catch (e) {
    print('Error deleting category: $e');
  }
  await getAllCategories();

}


//Product Controllers are given below




ValueNotifier<List<ProductModel>> productListNotifier = ValueNotifier([]);

Future<void> getAllProducts() async {
  final box1 = await Hive.openBox<ProductModel>('product_db');
  productListNotifier.value.clear();
  productListNotifier.value.addAll(box1.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  productListNotifier.notifyListeners();
  print('All Categories are listed');
}



// Function to update a category in Hive
Future<void> updateProducts(ProductModel updatedProduct) async {
  try {
    var box1 = await Hive.openBox<ProductModel>('product_db');
    int index =
        box1.values.toList().indexWhere((cat) => cat.id == updatedProduct.id);
    if (index != -1) {
      box1.putAt(index, updatedProduct);
    } else {
      throw 'Product not found';
    } // Notify listeners after updating
  } catch (error) {
    print('Failed to update product: $error');
    throw 'Failed to update product: $error';
  }
  getAllProducts();
}



Future<void> addProducts(ProductModel product) async {
  final box1 = await Hive.openBox<ProductModel>('product_db');
  const uuid = Uuid();
  final uuidString = uuid.v4(); // Generate UUID as a string
  final id = uuidString.hashCode.abs(); // Convert UUID string to integer
  product.id = id;
  await box1.add(product);

  getAllProducts();
} 

Future<void> deleteProducts(int id) async {
  try {
    final box1 = await Hive.openBox<ProductModel>('product_db');
      await box1.delete(id);
      print('Product with ID $id deleted successfully.');
      productListNotifier.value.clear();
      
    await box1.close();
  } catch (e) {
    print('Error deleting Product: $e');
  }
  await getAllProducts();
}
