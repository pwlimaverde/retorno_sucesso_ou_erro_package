import 'retorno_sucesso_ou_erro.dart';

abstract class UseCase<R, Parametros> {
  Future<RetornoSucessoOuErro<R>> call(Parametros parametros);
}

class NoParams {}

// class Parametros extends Equatable {
//   final int number;

//   Parametros({@required this.number});

//   @override
//   List<Object> get props => [number];
// }
