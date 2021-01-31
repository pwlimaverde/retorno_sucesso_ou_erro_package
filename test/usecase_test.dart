import 'package:flutter_test/flutter_test.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/repositorio.dart';

class RepoImpl implements Repositorio<bool, NoParams> {
  final RetornoSucessoOuErro<bool> result;

  RepoImpl(this.result);

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required NoParams parametros}) async {
    return result;
  }
}

class ChecarConeccaoUsecase extends UseCase<bool, NoParams> {
  final Repositorio<bool, NoParams> repositorio;

  ChecarConeccaoUsecase({required this.repositorio});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required NoParams parametros}) async {
    final resultado = await retornoRepositorio(
      repositorio: repositorio,
      erro: "teste usecase",
      parametros: NoParams(),
    );
    return resultado;
  }
}

void main() {
  late ChecarConeccaoUsecase checarConeccaoUseCase;
  late RepoImpl repositorio;

  test('Deve retornar um sucesso com true', () async {
    repositorio = RepoImpl(SucessoRetorno<bool>(resultado: true));
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um sucesso com false', () async {
    repositorio = RepoImpl(SucessoRetorno<bool>(resultado: false));
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<SucessoRetorno<bool>>());
  });
}
