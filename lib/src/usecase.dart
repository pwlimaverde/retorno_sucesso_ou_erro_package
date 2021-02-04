import 'utilitarios/erros.dart';
import 'repositorio.dart';
import 'utilitarios/retorno_sucesso_ou_erro.dart';

abstract class UseCase<R, Parametros> {
  Future<RetornoSucessoOuErro<R>> call({required Parametros parametros});

  Future<RetornoSucessoOuErro<R>> retornoRepositorio({
    required String erro,
    required Parametros parametros,
    required Repositorio<R, Parametros> repositorio,
  }) async {
    try {
      final resultado = await repositorio(parametros: parametros);
      return resultado;
    } catch (e) {
      return ErroRetorno<R>(
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
