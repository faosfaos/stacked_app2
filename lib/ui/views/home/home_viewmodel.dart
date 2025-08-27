import 'package:stacked/stacked.dart';
import 'package:stacked_app2/core/constants/used_database.dart';
import 'package:stacked_app2/data/repositories/todo_repository.dart';
import 'package:stacked_app2/models/todo.dart';

/// Ana sayfanın ViewModel sınıfı
/// Stacked mimarisi kullanarak todo işlemlerini yönetir
class HomeViewModel extends BaseViewModel {
  /// Veritabanı işlemlerini gerçekleştiren repository instance'ı
  final TodoRepository _dataBaseRepository;

  /// Constructor - Dependency injection ile TodoRepository alır
  /// Eğer repository verilmezse varsayılan database kullanılır
  HomeViewModel({TodoRepository? dataBaseRepository})
      : _dataBaseRepository = dataBaseRepository ?? usedDatabase;

  /// Todo listesini saklar
  List<Todo> todoList = [];

  /// Veritabanından tüm todo'ları getirir
  /// Loading durumunu otomatik olarak yönetir
  void fetchTodos() async {
    todoList = await runBusyFuture(_dataBaseRepository.fetchTodos(),
        busyObject: todoList);
  }

  /// Yeni bir todo ekler ve listeyi günceller
  void addTodo(Todo todo) async {
    await _dataBaseRepository.addTodo(todo: todo);
    fetchTodos(); // Listeyi yeniler
  }

  /// Bir todo'yu siler ve listeyi günceller
  void deleteTodo(Todo todo) async {
    await _dataBaseRepository.deleteTodo(todoID: todo.id ?? -1);
    fetchTodos(); // Listeyi yeniler
  }

  /// Bir todo'yu günceller
  /// Listeyi güncellemez
  /// Guncellemeyi HookWidget yapar
  Future<void> updateTodo(Todo todo) async {
    await _dataBaseRepository.updateTodo(todo: todo);
  }

  /// Todo'nun tamamlanma durumunu değiştirir
  /// Listeyi güncellemez
  /// Guncellemeyi HookWidget yapar
  void toggleTodo(Todo todo) async {
    await _dataBaseRepository.toggleTodo(todo: todo);
  }
}
