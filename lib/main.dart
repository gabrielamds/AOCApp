import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'data/questions.dart'; // Import the questions.dart file

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
  final List<Map<String, dynamic>> perguntas = getPerguntas(); // Use the imported questions list

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
  bool mostrarRespostaCorreta = false; // Adicionar variável para controlar a exibição da resposta correta

  @override
  void initState() {
    super.initState();
    _selecionarPerguntasPorDificuldade();
    iniciarCronometro();
  }

  void _selecionarPerguntasPorDificuldade() {
    List<Map<String, dynamic>> faceis = [];
    List<Map<String, dynamic>> medias = [];
    List<Map<String, dynamic>> dificeis = [];

    for (var pergunta in perguntas) {
      if (pergunta['dificuldade'] == 'facil') {
        faceis.add(pergunta);
      } else if (pergunta['dificuldade'] == 'media') {
        medias.add(pergunta);
      } else if (pergunta['dificuldade'] == 'dificil') {
        dificeis.add(pergunta);
      }
    }

    faceis.shuffle();
    medias.shuffle();
    dificeis.shuffle();

    perguntas.clear();
    perguntas.addAll(faceis.take(8));
    perguntas.addAll(medias.take(6));
    perguntas.addAll(dificeis.take(6));

    // Adicionar logs para verificar a distribuição das questões
    print('Questões fáceis selecionadas: ${faceis.take(8).length}');
    print('Questões médias selecionadas: ${medias.take(6).length}');
    print('Questões difíceis selecionadas: ${dificeis.take(6).length}');
    print('Total de questões selecionadas: ${perguntas.length}');
  }

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
        mostrarRespostaCorreta = true; // Ativar a exibição da resposta correta
      });
      respostasCorretas.add(false);
      _mostrarDialogo(
        'Resposta Errada!',
        'Você perdeu! Sua nota final: ${nota.toStringAsFixed(2)}.',
        mostrarRespostaCorreta: true,
      );
    }
  }

  void _mostrarDialogo(String titulo, String mensagem, {bool continuar = false, bool reiniciar = false, bool mostrarRespostaCorreta = false}) {
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
          if (mostrarRespostaCorreta)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _mostrarRespostaCorreta();
              },
              child: const Text('Ver a Resposta Correta'),
            ),
        ],
      ),
    );
  }

  void _mostrarRespostaCorreta() {
    setState(() {
      alternativasInativas = [true, true, true, true];
      alternativasInativas[perguntas[perguntaAtual]['correta']] = false;
      tentarSorteDisponivel = false;
      ajudaProfessoraDisponivel = false;
      ajudaUniversitariosDisponivel = false;
      pulosRestantes = 0;
      bloqueio = true;
    });
  }

  void _proximaPergunta() {
    setState(() {
      perguntaAtual++;
      segundosRestantes = 45;
      bloqueio = false;
      alternativasInativas = [false, false, false, false]; // Reativa todas as alternativas
      mostrarRespostaCorreta = false; // Desativar a exibição da resposta correta
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
    if (mostrarRespostaCorreta) return; // Desativa a opção "Parar" quando a resposta correta está sendo mostrada

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
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF383A65), Color(0xFF383A65)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
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
                          backgroundColor: mostrarRespostaCorreta && index == perguntas[perguntaAtual]['correta'] ? Colors.green : Colors.white,
                          foregroundColor: Color(0xFF2E2E2E),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 12, // Reduced font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text(
                          pergunta['alternativas'][index],
                          textAlign: TextAlign.center,
                        ),
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
                  Column(
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
                        child: _buildButton('Parar', mostrarRespostaCorreta ? null : _parar),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
    return SizedBox(
      width: 100,
      height: 80,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFFD8D5EA),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
