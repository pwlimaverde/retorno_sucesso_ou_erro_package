abstract class AppError implements Exception {}

class ErroInesperado implements AppError {
  final String mensagem;

  ErroInesperado({required this.mensagem});

  @override
  String toString() {
    return "ErroInesperado - $mensagem";
  }
}
