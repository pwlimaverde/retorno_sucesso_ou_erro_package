import 'datasource.dart';
import 'erros.dart';
import 'retorno_sucesso_ou_erro.dart';

abstract class Repositorio<R, Parametros> {
  Future<RetornoSucessoOuErro<R>> call({required Parametros parametros});

  Future<RetornoSucessoOuErro<R>> retornoDatasource({
    required String erro,
    required Parametros parametros,
    required Datasource<R, Parametros> datasource,
  }) async {
    try {
      final resultado = await datasource(parametros: parametros);
      return resultado;
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - $erro",
        ),
      );
    }
  }
}
