import '../../../../retorno_sucesso_ou_erro_package.dart';
import '../../../utilitarios/Parametros.dart';

class RetornoResultadoRepositorio
    extends Repositorio<bool, ParametrosRetornoResultado> {
  final Datasource<bool, ParametrosRetornoResultado> datasource;

  RetornoResultadoRepositorio({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required ParametrosRetornoResultado parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErroRetornoResultado(
        mensagem: "${parametros.mensagemErro} Cod.02-1",
      ),
      parametros: parametros,
    );
    return resultado;
  }
}
