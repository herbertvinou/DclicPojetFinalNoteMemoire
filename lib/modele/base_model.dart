abstract class BaseModel<T> {

  /// Convertit un objet Dart vers une Map SQLite
  Map<String, dynamic> toMap();

}