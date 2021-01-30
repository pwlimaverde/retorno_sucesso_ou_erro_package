import 'erros.dart';
import 'repositorio.dart';
import 'retorno_sucesso_ou_erro.dart';

abstract class UseCase<R, Parametros> {
  Future<RetornoSucessoOuErro<R>> call({required Parametros parametros});

  Future<RetornoSucessoOuErro<R>> retorno({
    required String erro,
    required Parametros parametros,
    required Repositorio<R, Parametros> repositorio,
  }) async {
    try {
      RetornoSucessoOuErro<R> resultado =
          await repositorio(parametros: parametros);
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

class NoParams {}

// class Parametros extends Equatable {
//   final int number;

//   Parametros({@required this.number});

//   @override
//   List<Object> get props => [number];
// }
