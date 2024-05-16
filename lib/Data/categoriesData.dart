import '../exports.dart';

class CategoriesData{

  static Map<String,dynamic> categoriesMap = {
    "Desayuno" : "assets/categories/breakfast.jpg",
    "Almuerzo" : "assets/categories/lunch.png",
    "Postres" :  "assets/categories/desserts.png",
    "Tartas" : "assets/categories/cakes.png",
    "Helados" : "assets/categories/ice_cream.png",
    "Batidos" : "assets/categories/smoothy.png"
  };

  static insertCategories() async {
    // A method that inserts categories data
    CategoriesRecipe.createCategoriesTable(); // Executed once!

    for (String category in categoriesMap.keys){
      CategoriesRecipe.insertCategoryIntoTable(
          CategoriesRecipe(categoryImage: categoriesMap[category], categoryName: category)
      );
    }
  }

}