import '../../../../retorno_sucesso_ou_erro_package.dart';
import '../../../utilitarios/Parametros.dart';
import '../repositories/retorno_bool_repository.dart';
import '../usecases/retorno_bool_usecase.dart';

class RetornoBoolPresenter {
  final Datasource<bool, ParametrosRetornoBool> datasource;
  final bool mostrarTempoExecucao;
  final String nomeFeature;

  RetornoBoolPresenter({
    required this.datasource,
    required this.mostrarTempoExecucao,
    required this.nomeFeature,
  });

  Future<RetornoSucessoOuErro<bool>> retornoBool(
      {required ParametrosRetornoBool parametros}) async {
    TempoExecucao tempo = TempoExecucao();
    if (mostrarTempoExecucao) {
      tempo.iniciar();
    }
    final resultado = await RetornoBoolUsecase(
      repositorio: RetornoBoolRepositorio(
        datasource: datasource,
      ),
    )(parametros: parametros);
    if (mostrarTempoExecucao) {
      tempo.terminar();
      print("Tempo de Execução do $nomeFeature: ${tempo.calcularExecucao()}ms");
    }
    return resultado;
  }
}
