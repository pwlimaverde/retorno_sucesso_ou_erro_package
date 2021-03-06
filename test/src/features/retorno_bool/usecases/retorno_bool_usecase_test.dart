import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/features/retorno_bool/usecases/retorno_bool_usecase.dart';
import 'package:retorno_sucesso_ou_erro_package/src/utilitarios/Parametros.dart';

class RetornoBoolRepositorioMock extends Mock
    implements Repositorio<bool, ParametrosRetornoBool> {}

void main() {
  late Repositorio<bool, ParametrosRetornoBool> repositorio;
  late UseCase<bool, ParametrosRetornoBool> retornoBoolUsecase;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    repositorio = RetornoBoolRepositorioMock();
    retornoBoolUsecase = RetornoBoolUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com bool', () async {
    tempo.iniciar();
    when(repositorio)
        .calls(#call)
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(resultado: true)));
    final result = await retornoBoolUsecase(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do SalvarHeader: ${tempo.calcularExecucao()}ms");
    expect(result, isA<SucessoRetorno<bool>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        true);
  });

  test(
      'Deve retornar um ErroRetornoBool com Erro ao salvar os dados do header Cod.01-1',
      () async {
    tempo.iniciar();
    when(repositorio).calls(#call).thenAnswer(
        (_) => Future.value(SucessoRetorno<bool>(resultado: false)));
    final result = await retornoBoolUsecase(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do SignIn: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar um ErroRetornoBool com Erro ao salvar os dados do header Cod.02-1',
      () async {
    tempo.iniciar();
    when(repositorio).calls(#call).thenAnswer(
          (_) => Future.value(
            ErroRetorno<bool>(
              erro: ErroRetornoBool(
                mensagem: "Erro ao salvar os dados do header Cod.02-1",
              ),
            ),
          ),
        );
    final result = await retornoBoolUsecase(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do SignIn: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar um ErroRetornoBool, pela exeption do repositorio com Erro ao salvar os dados do header Cod.01-2',
      () async {
    tempo.iniciar();
    when(repositorio).calls(#call).thenThrow(Exception());
    final result = await retornoBoolUsecase(
      parametros: ParametrosSalvarHeader(
        corHeader: {
          "r": 60,
          "g": 60,
          "b": 60,
        },
        doc: 'testedoc',
        nome: 'novidades',
        prioridade: 1,
        user: 'paulo',
      ),
    );
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de Execução do SignIn: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });
}

class ParametrosSalvarHeader implements ParametrosRetornoBool {
  final String doc;
  final String nome;
  final int prioridade;
  final Map corHeader;
  final String user;

  ParametrosSalvarHeader({
    required this.doc,
    required this.nome,
    required this.prioridade,
    required this.corHeader,
    required this.user,
  });
  @override
  String get mensagemErro => "Erro ao salvar os dados do Header Cod.01-1";
}
