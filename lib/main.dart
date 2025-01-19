import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const QuemQuerSerEngenheiro());
}

class QuemQuerSerEngenheiro extends StatelessWidget {
  const QuemQuerSerEngenheiro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quem Quer Ser um Engenheiro?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

// Tela Inicial
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quem Quer Ser um Engenheiro?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaPerguntas()),
                );
              },
              child: const Text('Iniciar Jogo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _mostrarInstrucoes(context);
              },
              child: const Text('Instruções'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarInstrucoes(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Instruções'),
        content: const Text(
            'Responda as perguntas corretamente para acumular pontos e se formar! '
            'Use as ajudas disponíveis, mas cuidado com o tempo de 45 segundos por pergunta. '
            'Boa sorte!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }
}

// Tela de Perguntas
class TelaPerguntas extends StatefulWidget {
  const TelaPerguntas({super.key});

  @override
  State<TelaPerguntas> createState() => _TelaPerguntasState();
}

class _TelaPerguntasState extends State<TelaPerguntas> {
  final List<Map<String, dynamic>> perguntas = [
    {
      'texto': 'Qual a principal função da memória RAM?',
      'alternativas': [
        'Armazenar dados permanentemente.',
        'Armazenar dados temporariamente para acesso rápido.',
        'Processar dados gráficos.',
        'Controlar os periféricos do sistema.',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que é um barramento no computador?',
      'alternativas': [
        'Uma rota de transporte de dados entre componentes.',
        'Um tipo de memória secundária.',
        'O processador do sistema.',
        'Um componente responsável pela energia.',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual a função do processador em um computador?',
      'alternativas': [
        'Armazenar dados permanentemente.',
        'Armazenar dados temporariamente para acesso rápido.',
        'Processar dados gráficos.',
        'Executar instruções e cálculos.',
      ],
      'correta': 3,
    },
    {
      'texto': 'O que é um sistema operacional?',
      'alternativas': [
        'Um tipo de memória secundária.',
        'Um componente responsável pela energia.',
        'O processador do sistema.',
        'Um software que gerencia recursos do computador.',
      ],
      'correta': 3,
    },
    {
      'texto': 'Qual a função de um HD em um computador?',
      'alternativas': [
        'Armazenar dados temporariamente para acesso rápido.',
        'Armazenar dados permanentemente.',
        'Processar dados gráficos.',
        'Controlar os periféricos do sistema.',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que é um periférico de entrada?',
      'alternativas': [
        'Um dispositivo que envia dados para o computador.',
        'Um dispositivo que recebe dados do computador.',
        'Um dispositivo que armazena dados.',
        'Um dispositivo que processa dados.',
      ],
      'correta': 0,
    },
    {
      'texto': 'O que é um periférico de saída?',
      'alternativas': [
        'Um dispositivo que envia dados para o computador.',
        'Um dispositivo que recebe dados do computador.',
        'Um dispositivo que armazena dados.',
        'Um dispositivo que processa dados.',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que é um periférico de armazenamento?',
      'alternativas': [
        'Um dispositivo que envia dados para o computador.',
        'Um dispositivo que recebe dados do computador.',
        'Um dispositivo que armazena dados.',
        'Um dispositivo que processa dados.',
      ],
      'correta': 2,
    },
    {
      'texto': 'O que é um periférico de processamento?',
      'alternativas': [
        'Um dispositivo que envia dados para o computador.',
        'Um dispositivo que recebe dados do computador.',
        'Um dispositivo que armazena dados.',
        'Um dispositivo que processa dados.',
      ],
      'correta': 3,
    },
    {
      'texto': 'O que é um periférico de comunicação?',
      'alternativas': [
        'Um dispositivo que envia dados para o computador.',
        'Um dispositivo que recebe dados do computador.',
        'Um dispositivo que armazena dados.',
        'Um dispositivo que processa dados.',
      ],
      'correta': 0,
    },
    // Adicione mais perguntas...
  ];

  int perguntaAtual = 0;
  int pontuacao = 0;
  int pulosRestantes = 3;
  int segundosRestantes = 45;
  bool bloqueio = false;
  bool tentarSorteDisponivel = true; // Para controlar se "Tentar a Sorte" pode ser usado
  late Timer timer;
  List<bool> respostasCorretas = [];
  List<bool> alternativasInativas = [false, false, false, false]; // Para desabilitar alternativas erradas

  void iniciarCronometro() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (segundosRestantes == 0) {
        timer.cancel();
        _tempoEsgotado();
      } else {
        setState(() {
          segundosRestantes--;
        });
      }
    });
  }

  void _tempoEsgotado() {
    _mostrarDialogo(
      'Tempo esgotado!',
      'Você perdeu! Sua pontuação final: R\$${pontuacao}.',
      reiniciar: true,
    );
  }

  void _responder(int index) {
    if (bloqueio) return;

    setState(() {
      bloqueio = true;
    });
    timer.cancel();

    if (index == perguntas[perguntaAtual]['correta']) {
      setState(() {
        pontuacao += 1000 * (perguntaAtual + 1);
        respostasCorretas.add(true);
      });
      _mostrarDialogo(
        'Resposta Correta!',
        'Você ganhou R\$${pontuacao}!',
        continuar: true,
      );
    } else {
      respostasCorretas.add(false);
      _mostrarDialogo(
        'Resposta Errada!',
        'Você perdeu! Sua pontuação final: R\$${pontuacao}.',
        reiniciar: true,
      );
    }
  }

  void _mostrarDialogo(String titulo, String mensagem, {bool continuar = false, bool reiniciar = false}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          if (continuar)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _proximaPergunta();
              },
              child: const Text('Continuar'),
            ),
          if (reiniciar)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaInicial()),
                  (route) => false,
                );
              },
              child: const Text('Voltar ao Início'),
            ),
        ],
      ),
    );
  }

  void _proximaPergunta() {
    setState(() {
      perguntaAtual++;
      segundosRestantes = 45;
      bloqueio = false;
      alternativasInativas = [false, false, false, false]; // Reativa todas as alternativas
    });
    if (perguntaAtual >= perguntas.length) {
      _mostrarDialogo(
        'Parabéns!',
        'Você concluiu o jogo com R\$${pontuacao}!',
        reiniciar: true,
      );
    } else {
      iniciarCronometro();
    }
  }

  void _usarCarta() {
  if (!tentarSorteDisponivel) return;

  setState(() {
    tentarSorteDisponivel = false; // Desativa a opção "Tentar a Sorte"
  });

  int cartas = Random().nextInt(4); // Gera um número aleatório entre 0 e 3

  // Exibe a caixa de mensagem
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Tentar a Sorte'),
      content: Text('Serão desativadas $cartas alternativas incorretas.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            // Desabilita as alternativas erradas
            setState(() {
              for (int i = 0; i < perguntas[perguntaAtual]['alternativas'].length; i++) {
                if (i != perguntas[perguntaAtual]['correta'] && cartas > 0) {
                  alternativasInativas[i] = true;
                  cartas--;
                }
              }
            });
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

  void _ajudaProfessora() {
    // Implementar lógica de ajuda da professora
    setState(() {
      respostasCorretas.clear();
      // Exiba a resposta correta dada pela professora
    });
  }

  void _ajudaUniversitarios() {
    // Implementar lógica de ajuda dos universitários
    setState(() {
      respostasCorretas.clear();
      // Exiba a ajuda dos universitários
    });
  }

  void _pularQuestao() {
    if (pulosRestantes > 0) {
      setState(() {
        pulosRestantes--;
        perguntaAtual++;
      });
    } else {
      _mostrarDialogo(
        'Sem pulos restantes!',
        'Você não pode pular mais questões.',
        reiniciar: false,
      );
    }
  }

  void _parar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Parar o Jogo'),
        content: const Text('Você tem certeza que deseja parar o jogo?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _mostrarDialogo(
                'Você Parou!',
                'Você acumulou R\$${pontuacao}. Obrigado por jogar!',
                reiniciar: true,
              );
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    iniciarCronometro();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = perguntas[perguntaAtual];
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta ${perguntaAtual + 1}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pergunta['texto'],
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Exibe as alternativas
            ...List.generate(pergunta['alternativas'].length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ElevatedButton(
                  onPressed: alternativasInativas[index] ? null : () => _responder(index),
                  child: Text(pergunta['alternativas'][index]),
                ),
              );
            }),
            const SizedBox(height: 20),
            // Exibe os botões abaixo das alternativas
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: tentarSorteDisponivel ? _usarCarta : null,
                  child: const Text('Tentar a Sorte'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pularQuestao,
                  child: Text('Pular Questão (${pulosRestantes})'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _parar,
                  child: const Text('Parar'),
                ),
                const SizedBox(height: 10),
                Text('Tempo: $segundosRestantes s'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
