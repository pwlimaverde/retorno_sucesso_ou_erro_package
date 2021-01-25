import 'erros.dart';

abstract class RetornoSucessoOuErro<R> {
  const RetornoSucessoOuErro();
  fold({
    required R Function(SucessoRetorno) sucesso,
    required AppErro Function(ErroRetorno) erro,
  }) {
    final _this = this;
    if (_this is SucessoRetorno<R>) {
      return sucesso(_this);
    } else {
      return erro(_this as ErroRetorno);
    }
  }
}

class SucessoRetorno<R> extends RetornoSucessoOuErro<R> {
  final R resultado;
  const SucessoRetorno({required this.resultado});
}

class ErroRetorno<AppErro> extends RetornoSucessoOuErro<AppErro> {
  final AppErro erro;
  const ErroRetorno({required this.erro});
}
