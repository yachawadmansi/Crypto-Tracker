import 'package:shared_preferences/shared_preferences.dart';
class LocalStorage{
  // static Future<bool> saveTheme(String theme) async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool result = await sharedPreferences.setString("theme", theme);
  //   return result;
  // }
  // static Future<String?> getTheme() async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? currentTheme = sharedPreferences.getString("theme");
  //   return currentTheme;
  // }

  static Future<bool> addFavourite(String id ) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    List <String> favourites = sharedPreferences.getStringList("Favourites") ?? [];
    favourites.add(id);
    return await sharedPreferences.setStringList("favourites", favourites);
  }
  static Future<bool> removeFavourite(String id ) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List <String> favourites = sharedPreferences.getStringList("Favourites") ?? [];
    favourites.remove(id);
    return await sharedPreferences.setStringList("favourites", favourites);
  }
  static Future<List<String>> fetchFavourites() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favorites")?? [];

  }
}