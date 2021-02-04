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
      final R resultado = await datasource(parametros: parametros);
      return SucessoRetorno<R>(resultado: resultado);
    } catch (e) {
      return ErroRetorno<R>(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - $erro",
        ),
      );
    }
  }
}
