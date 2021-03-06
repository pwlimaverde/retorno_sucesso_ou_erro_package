import '../../../../retorno_sucesso_ou_erro_package.dart';
import '../../../utilitarios/Parametros.dart';

class RetornoBoolRepositorio extends Repositorio<bool, ParametrosRetornoBool> {
  final Datasource<bool, ParametrosRetornoBool> datasource;

  RetornoBoolRepositorio({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required ParametrosRetornoBool parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErroRetornoBool(
        mensagem: "${parametros.mensagemErro} Cod.02-1",
      ),
      parametros: parametros,
    );
    return resultado;
  }
}
