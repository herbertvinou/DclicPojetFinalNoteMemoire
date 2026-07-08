import '../repositories/repository.dart';

abstract class BaseService {

  BaseService();

  /// Accès au Repository
  final Repository repository = Repository.instance;

}