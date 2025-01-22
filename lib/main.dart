import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io'; // Import the dart:io package

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF383A65)),
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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF383A65), Color.fromARGB(255, 83, 86, 133)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: -271,
            left: -24,
            child: Container(
              width: 542,
              height: 542,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF383A65).withOpacity(0.5),
              ),
            ),
          ),
          Center(
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
                _buildButton(context, 'Iniciar Jogo', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaPerguntas()),
                  );
                }),
                const SizedBox(height: 20),
                _buildButton(context, 'Instruções', () {
                  _mostrarInstrucoes(context);
                }),
                const SizedBox(height: 20),
                _buildButton(context, 'Sair', () => exit(0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF383A65),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
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
    {
      'texto': 'O que é um processador multi-core?',
      'alternativas': [
        'Um processador com múltiplos núcleos de processamento.',
        'Um processador com múltiplas unidades de memória.',
        'Um processador com múltiplas unidades de entrada e saída.',
        'Um processador com múltiplas unidades de controle.',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a função da memória cache?',
      'alternativas': [
        'Armazenar dados permanentemente.',
        'Armazenar dados temporariamente para acesso rápido.',
        'Processar dados gráficos.',
        'Controlar os periféricos do sistema.',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que é um pipeline em arquitetura de computadores?',
      'alternativas': [
        'Uma técnica para aumentar a velocidade de processamento.',
        'Uma técnica para aumentar a capacidade de armazenamento.',
        'Uma técnica para aumentar a qualidade gráfica.',
        'Uma técnica para aumentar a segurança do sistema.',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a função de um controlador de memória?',
      'alternativas': [
        'Gerenciar a comunicação entre a CPU e a memória.',
        'Gerenciar a comunicação entre a CPU e os dispositivos de entrada.',
        'Gerenciar a comunicação entre a CPU e os dispositivos de saída.',
        'Gerenciar a comunicação entre a CPU e os dispositivos de armazenamento.',
      ],
      'correta': 0,
    },
    {
      'texto': 'O que é um registrador em um processador?',
      'alternativas': [
        'Uma pequena unidade de armazenamento dentro da CPU.',
        'Uma unidade de armazenamento externa à CPU.',
        'Uma unidade de processamento gráfico.',
        'Uma unidade de controle de periféricos.',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a função de um barramento de dados?',
      'alternativas': [
        'Transportar dados entre diferentes componentes do computador.',
        'Armazenar dados permanentemente.',
        'Processar dados gráficos.',
        'Controlar os periféricos do sistema.',
      ],
      'correta': 0,
    },
    {
      'texto': 'O que é um sistema de memória virtual?',
      'alternativas': [
        'Um sistema que permite a execução de programas maiores que a memória física.',
        'Um sistema que permite a execução de programas menores que a memória física.',
        'Um sistema que permite a execução de programas gráficos.',
        'Um sistema que permite a execução de programas de controle de periféricos.',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a função de um disco rígido (HD)?',
      'alternativas': [
        'Armazenar dados permanentemente.',
        'Armazenar dados temporariamente para acesso rápido.',
        'Processar dados gráficos.',
        'Controlar os periféricos do sistema.',
      ],
      'correta': 0,
    },
    {
      'texto': 'O que é um SSD?',
      'alternativas': [
        'Um dispositivo de armazenamento de estado sólido.',
        'Um dispositivo de armazenamento de disco rígido.',
        'Um dispositivo de armazenamento de fita magnética.',
        'Um dispositivo de armazenamento óptico.',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a função de um sistema operacional?',
      'alternativas': [
        'Gerenciar os recursos do computador.',
        'Armazenar dados permanentemente.',
        'Processar dados gráficos.',
        'Controlar os periféricos do sistema.',
      ],
      'correta': 0,
    },
  ];

  int perguntaAtual = 0;
  int pontuacao = 0;
  int pulosRestantes = 3;
  int segundosRestantes = 45;
  bool bloqueio = false;
  bool tentarSorteDisponivel = true; // Para controlar se "Tentar a Sorte" pode ser usado
  bool ajudaProfessoraDisponivel = true; // Para controlar se "Ajuda da Professora" pode ser usado
  bool ajudaUniversitariosDisponivel = true; // Para controlar se "Ajuda dos Universitários" pode ser usado
  late Timer timer;
  List<bool> respostasCorretas = [];
  List<bool> alternativasInativas = [false, false, false, false]; // Para desabilitar alternativas erradas
  int questoesRespondidas = 0; // Adicionar variável para contar questões respondidas
  double nota = 0; // Adicionar variável para a nota como decimal
  int pontos = 0; // Adicionar variável para os pontos

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
      'Você perdeu! Sua nota final: ${nota.toStringAsFixed(2)}.',
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
      questoesRespondidas++; // Incrementar questões respondidas
      if (perguntaAtual < 5) {
        pontos += 1; // Primeira rodada
      } else if (perguntaAtual < 10) {
        pontos += 2; // Segunda rodada
      } else if (perguntaAtual < 15) {
        pontos += 4; // Terceira rodada
      } else {
        pontos += 5; // Pergunta final
      }
      nota = (10 * pontos / 40).clamp(0, 10); // Calcular a nota com base nos pontos e limitar a 10
      respostasCorretas.add(true);
    });
    if (nota >= 10) {
      _mostrarTelaFinal(
        context,
        'Parabéns!\nVocê tirou ${nota.toStringAsFixed(2)} na prova de AOC!\nAgora não precisa sofrer tanto com os trabalhos!!!',
      );
    } else {
      _mostrarDialogo(
        'Resposta Correta!',
        'Sua nota atual: ${nota.toStringAsFixed(2)}.',
        continuar: true,
      );
    }
  } else {
    setState(() {
      nota /= 2; // Divide the score by two when the player loses
    });
    respostasCorretas.add(false);
    if (nota >= 6) {
      _mostrarDialogo(
        'Resposta Errada!',
        'Você perdeu! Mas pelo menos você tirou ${nota.toStringAsFixed(2)}! Ainda da para passar ein!',
        reiniciar: true,
      );
    } else {
      _mostrarDialogo(
        'Resposta Errada!',
        'Você perdeu! Sua nota final: ${nota.toStringAsFixed(2)}.',
        reiniciar: true,
      );
    }
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
    if (perguntaAtual >= perguntas.length || nota >= 10) {
      _mostrarTelaFinal(
        context,
        'Parabéns!\nVocê tirou ${nota.toStringAsFixed(2)} na prova de AOC!\nAgora não precisa sofrer tanto com os trabalhos!!!',
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
  if (!ajudaProfessoraDisponivel) return;

  setState(() {
    ajudaProfessoraDisponivel = false; // Desativa a opção "Ajuda da Professora"
  });

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Ajuda da Professora'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Esperando a resposta...'),
              const SizedBox(height: 20),
              TweenAnimationBuilder<Duration>(
                duration: Duration(seconds: segundosRestantes),
                tween: Tween(begin: Duration(seconds: segundosRestantes), end: Duration.zero),
                onEnd: () {
                  Navigator.of(ctx).pop();
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final seconds = value.inSeconds;
                  return Text('Tempo: $seconds s');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ),
  );
}

void _ajudaUniversitarios() {
  if (!ajudaUniversitariosDisponivel) return;

  setState(() {
    ajudaUniversitariosDisponivel = false; // Desativa a opção "Ajuda dos Universitários"
  });

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Ajuda dos Universitários'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Esperando a resposta...'),
              const SizedBox(height: 20),
              TweenAnimationBuilder<Duration>(
                duration: Duration(seconds: segundosRestantes),
                tween: Tween(begin: Duration(seconds: segundosRestantes), end: Duration.zero),
                onEnd: () {
                  Navigator.of(ctx).pop();
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final seconds = value.inSeconds;
                  return Text('Tempo: $seconds s');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ),
  );
}

  void _pularQuestao() {
  if (pulosRestantes > 0) {
    setState(() {
      pulosRestantes--;
      perguntaAtual++;
      segundosRestantes = 45;
      bloqueio = false;
      alternativasInativas = [false, false, false, false]; // Reativa todas as alternativas
    });
    if (perguntaAtual >= perguntas.length || nota >= 10) {
      _mostrarDialogo(
        'Parabéns!',
        'Você concluiu o jogo com nota ${nota.toStringAsFixed(2)}!',
        reiniciar: true,
      );
    } else {
      timer.cancel(); // Cancel the current timer
      iniciarCronometro(); // Restart the timer
    }
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
              if (nota >= 6 && nota < 10) {
                _mostrarDialogo(
                  'Você Parou!',
                  'Você perdeu! Mas pelo menos você tirou ${nota.toStringAsFixed(2)}! Ainda da para passar ein!',
                  reiniciar: true,
                );
              } else {
                _mostrarDialogo(
                  'Você Parou!',
                  'Sua nota final: ${nota.toStringAsFixed(2)}. Obrigado por jogar!',
                  reiniciar: true,
                );
              }
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

void _mostrarTelaFinal(BuildContext context, String mensagem) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (ctx) => Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF383A65), Color(0xFF676BBD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.celebration,
                color: Colors.white,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                mensagem,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const TelaInicial()),
                    (route) => false,
                  );
                },
                child: const Text('Voltar ao Início'),
              ),
            ],
          ),
        ),
      ),
    ),
    (route) => false,
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
    double notaSeErrar = (nota / 2).clamp(0, 10);
    double notaSeParar = nota;
    double notaSeAcertar = ((10 * (pontos + (perguntaAtual < 5 ? 1 : perguntaAtual < 10 ? 2 : perguntaAtual < 15 ? 4 : 5)) / 40)).clamp(0, 10);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta ${perguntaAtual + 1}'),
        centerTitle: true,
        backgroundColor: Color(0xFF383A65),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF383A65), Color(0xFF383A65)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exibe o cronômetro
              Center(
                child: Container(
                  width: 52,
                  height: 52,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 6.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                      CircularProgressIndicator(
                        value: segundosRestantes / 45,
                        strokeWidth: 6.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Text(
                        '$segundosRestantes',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                pergunta['texto'],
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              // Exibe as alternativas
              ...List.generate(pergunta['alternativas'].length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    onPressed: alternativasInativas[index] ? null : () => _responder(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF383A65),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(pergunta['alternativas'][index]),
                  ),
                );
              }),
              const SizedBox(height: 20),
              // Exibe os indicadores de nota
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNotaIndicator('Errar', notaSeErrar),
                  _buildNotaIndicator('Parar', notaSeParar),
                  _buildNotaIndicator('Acertar', notaSeAcertar),
                ],
              ),
              const SizedBox(height: 20),
              // Exibe os botões abaixo das alternativas
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSmallButton('Tentar a Sorte', tentarSorteDisponivel ? _usarCarta : null),
                        _buildSmallButton('Pular Questão (${pulosRestantes})', pulosRestantes > 0 ? _pularQuestao : null),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSmallButton('Ajuda da Professora', ajudaProfessoraDisponivel ? _ajudaProfessora : null),
                        _buildSmallButton('Ajuda dos Universitários', ajudaUniversitariosDisponivel ? _ajudaUniversitarios : null),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: _buildButton('Parar', _parar),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton(String text, VoidCallback? onPressed) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF383A65),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF383A65),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildNotaIndicator(String label, double nota) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFD8D5EA),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF505054),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            nota.toStringAsFixed(2),
            style: const TextStyle(
              color: Color(0xFF505054),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final int segundosRestantes;

  TimerPainter({required this.segundosRestantes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final angle = 2 * pi * (segundosRestantes / 45);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
