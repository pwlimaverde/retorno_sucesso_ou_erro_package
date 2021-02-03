import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/repositorio.dart';

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

class RepoImplMock extends Mock implements Repositorio<bool, NoParams> {}

void main() {
  late Repositorio<bool, NoParams> repositorio;
  late ChecarConeccaoUsecase checarConeccaoUseCase;

  setUp(() {
    repositorio = RepoImplMock();
  });

  test('Deve retornar um sucesso com true', () async {
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    when(repositorio)
        .calls(#call)
        .thenAnswer((_) => Future.value(SucessoRetorno(resultado: true)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um sucesso com false', () async {
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    when(repositorio)
        .calls(#call)
        .thenAnswer((_) => Future.value(SucessoRetorno(resultado: false)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um Erro com ErroInesperado', () async {
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    when(repositorio).calls(#call).thenAnswer((_) => Future.value(
        ErroRetorno(erro: ErroInesperado(mensagem: "teste erro"))));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno>());
  });

  test('Deve retornar um Erro com ErroInesperado', () async {
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
    when(repositorio).calls(#call).thenThrow(Exception());
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno>());
  });

  // test('Deve retornar um sucesso com false', () async {
  //   resultado =
  //       DatasourceImpl(resultado: SucessoRetorno<bool>(resultado: false));
  //   repositorio = RepoImpl(datasource: resultado);
  //   checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
  //   final result = await checarConeccaoUseCase(parametros: NoParams());
  //   print(result.fold(
  //     sucesso: (value) => value.resultado,
  //     erro: (value) => value.erro,
  //   ));
  //   expect(result, isA<SucessoRetorno<bool>>());
  // });
}
