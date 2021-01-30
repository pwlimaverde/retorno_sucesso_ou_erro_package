import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ChecarConeccaoUsecaseMock extends Mock
    implements UseCase<bool, NoParams> {
  final RetornoSucessoOuErro<bool> repository;

  ChecarConeccaoUsecaseMock({required this.repository});

  @override
  Future<RetornoSucessoOuErro<bool>> call(NoParams parametros) async {
    RetornoSucessoOuErro<bool> check = await resultado(
        repositorio: Future.value(repository), erro: "Erro na usecase");

    return check;
  }
}

void main() {
  // ChecarConeccaoUsecaseMock dependencia;
  // RetornoSucessoOuErro<bool> repositorio;

  setUp(() {
    // repositorio = SucessoRetorno(resultado: true);
    // dependencia = ChecarConeccaoUsecaseMock(repository: repositorio);
  });

  test('Deve retornar um sucesso com true', () async {
    final dependencia =
        ChecarConeccaoUsecaseMock(repository: SucessoRetorno(resultado: true));

    when(await dependencia(NoParams()))
        .thenAnswer((value) => SucessoRetorno(resultado: true));
    final result = await dependencia(NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um sucesso com false', () async {
    final dependencia =
        ChecarConeccaoUsecaseMock(repository: SucessoRetorno(resultado: false));
    final result = await dependencia.call(NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um erro repositorio', () async {
    final dependencia = ChecarConeccaoUsecaseMock(
        repository:
            ErroRetorno(erro: ErroInesperado(mensagem: "erro no repositorio")));
    final result = await dependencia.call(NoParams());
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<ErroRetorno>());
  });
}
