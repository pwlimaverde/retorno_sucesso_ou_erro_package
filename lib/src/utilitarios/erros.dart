abstract class AppErro implements Exception {}

class ErroInesperado implements AppErro {
  final String mensagem;

  ErroInesperado({required this.mensagem});

  @override
  String toString() {
    return "ErroInesperado - $mensagem";
  }
}
