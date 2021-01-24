import 'package:flutter_test/flutter_test.dart';
import 'package:retorno_sucesso_ou_erro_package/src/erros.dart';
import 'package:retorno_sucesso_ou_erro_package/src/retorno_sucesso_ou_erro.dart';

void main() {
  test('Deve retornar um sucesso', () {
    final result = SucessoRetorno(resultado: "teste sucesso");
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<RetornoSucessoOuErro<String>>());
  });

  test('Deve retornar um sucesso com o resultado da String', () {
    final result = SucessoRetorno(resultado: "teste sucesso");
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));

    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        "teste sucesso");
  });

  test('Deve retornar um error', () {
    final result = ErrorRetorno(
      erro: ErroInesperado(
        mensagem: "teste erro",
      ),
    );
    print(result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    ));
    expect(result, isA<ErrorRetorno>());
  });
}
