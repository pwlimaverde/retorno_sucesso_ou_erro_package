import 'erros.dart';

abstract class RetornoSucessoOuErro<R> {
  const RetornoSucessoOuErro();
  fold({
    required R Function(SucessoRetorno) sucesso,
    required AppError Function(ErrorRetorno) erro,
  }) {
    final _this = this;
    if (_this is SucessoRetorno<R>) {
      return sucesso(_this);
    } else {
      return erro(_this as ErrorRetorno);
    }
  }
}

class SucessoRetorno<R> extends RetornoSucessoOuErro<R> {
  final R resultado;
  const SucessoRetorno({required this.resultado});
}

class ErrorRetorno<R> extends RetornoSucessoOuErro<R> {
  final AppError erro;
  const ErrorRetorno({required this.erro});
}
