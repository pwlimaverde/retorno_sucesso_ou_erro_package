abstract class AppErro implements Exception {}

class ErroInesperado implements AppErro {
  final String mensagem;

  ErroInesperado({required this.mensagem});

  @override
  String toString() {
    return "ErroInesperado - $mensagem";
  }
}

class ErroRetornoBool implements AppErro {
  final String mensagem;

  ErroRetornoBool({required this.mensagem});

  @override
  String toString() {
    return "ErroRetornoBool - $mensagem";
  }
}
