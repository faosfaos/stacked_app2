import 'package:stacked_app2/models/todo.dart';

/// Todo veri işlemlerini yöneten soyut repository sınıfı
/// Bu sınıf, todo verilerinin kaynağından bağımsız olarak
/// temel CRUD operasyonlarını tanımlar
abstract class TodoRepository {
  /// Tüm todo öğelerini getirir
  /// Returns: Todo öğelerinin listesi
  Future<List<Todo>> fetchTodos();
  
  /// Yeni bir todo öğesi ekler
  /// [todo]: Eklenecek todo öğesi
  /// Returns: Eklenen kayıt sayısı (başarılı ise 1)
  Future<int> addTodo({required Todo todo});
  
  /// Mevcut bir todo öğesini günceller
  /// [todo]: Güncellenecek todo öğesi
  /// Returns: Güncellenen kayıt sayısı (başarılı ise 1)
  Future<int> updateTodo({required Todo todo});
  
  /// Todo öğesinin tamamlanma durumunu değiştirir
  /// [todo]: Durumu değiştirilecek todo öğesi
  /// Returns: Güncellenen kayıt sayısı (başarılı ise 1)
  Future<int> toggleTodo({required Todo todo});
  
  /// Belirtilen ID'ye sahip todo öğesini siler
  /// [todoID]: Silinecek todo öğesinin ID'si
  /// Returns: Silinen kayıt sayısı (başarılı ise 1)
  Future<int> deleteTodo({required int todoID});
}
