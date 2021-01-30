import 'erros.dart';
import 'retorno_sucesso_ou_erro.dart';

abstract class UseCase<R, Parametros> {
  Future<RetornoSucessoOuErro<R>> call(Parametros parametros);

  Future<RetornoSucessoOuErro<R>> resultado(
      {required Future<RetornoSucessoOuErro<R>> repositorio,
      required String erro}) async {
    try {
      RetornoSucessoOuErro<R> resultado = await repositorio;
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
