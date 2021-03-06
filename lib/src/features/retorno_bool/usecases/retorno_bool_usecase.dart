import '../../../../retorno_sucesso_ou_erro_package.dart';
import '../../../utilitarios/Parametros.dart';

class RetornoBoolUsecase extends UseCase<bool, ParametrosRetornoBool> {
  final Repositorio<bool, ParametrosRetornoBool> repositorio;

  RetornoBoolUsecase({required this.repositorio});

  @override
  Future<RetornoSucessoOuErro<bool>> call({
    required ParametrosRetornoBool parametros,
  }) async {
    try {
      final resultado = await retornoRepositorio(
        repositorio: repositorio,
        erro: ErroRetornoBool(
          mensagem: "${parametros.mensagemErro} Cod.01-2",
        ),
        parametros: parametros,
      );
      if (resultado is SucessoRetorno<bool>) {
        if (!resultado.resultado) {
          return ErroRetorno(
            erro: ErroRetornoBool(
              mensagem: "${parametros.mensagemErro} Cod.01-1",
            ),
          );
        }
      }
      return resultado;
    } catch (e) {
      return ErroRetorno(
        erro: ErroRetornoBool(
          mensagem: "${e.toString()} - ${parametros.mensagemErro} Cod.01-3",
        ),
      );
    }
  }
}
