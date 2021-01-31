import 'retorno_sucesso_ou_erro.dart';

abstract class Repositorio<R, Parametros> {
  Future<RetornoSucessoOuErro<R>> call({required Parametros parametros});
}
