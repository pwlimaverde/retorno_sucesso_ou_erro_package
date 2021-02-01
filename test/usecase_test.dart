import 'package:flutter_test/flutter_test.dart';

import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/repositorio.dart';

class DatasourceImpl implements Datasource<bool, NoParams> {
  final RetornoSucessoOuErro<bool> resultado;
  DatasourceImpl({
    required this.resultado,
  });
  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required NoParams parametros}) async {
    return resultado;
  }
}

class RepoImpl extends Repositorio<bool, NoParams> {
  final Datasource<bool, NoParams> datasource;

  RepoImpl({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required NoParams parametros}) async {
    final result = await retornoDatasource(
        datasource: datasource,
        erro: "teste repositorio",
        parametros: NoParams());
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
  late Datasource<bool, NoParams> resultado;

  test('Deve retornar um sucesso com true', () async {
    resultado =
        DatasourceImpl(resultado: SucessoRetorno<bool>(resultado: true));
    repositorio = RepoImpl(datasource: resultado);
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um sucesso com false', () async {
    resultado =
        DatasourceImpl(resultado: SucessoRetorno<bool>(resultado: false));
    repositorio = RepoImpl(datasource: resultado);
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<SucessoRetorno<bool>>());
  });
}
