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
      'texto': 'Qual é a principal função de um dispositivo de entrada?',
      'alternativas': [
        'Processar dados',
        'Armazenar informações',
        'Fornecer dados ao computador',
        'Transmitir dados para outros dispositivos',
      ],
      'correta': 2,
    },
    {
      'texto': 'Qual dos dispositivos abaixo é considerado de armazenamento secundário?',
      'alternativas': [
        'Registradores',
        'Memória cache',
        'Disco rígido',
        'Unidade de controle',
      ],
      'correta': 2,
    },
    {
      'texto': 'O que caracteriza uma memória volátil?',
      'alternativas': [
        'Retém os dados após o desligamento',
        'Perde os dados quando o computador é desligado',
        'Tem grande capacidade de armazenamento',
        'É usada apenas para backup',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que é um SSD?',
      'alternativas': [
        'Uma memória volátil de alta velocidade',
        'Um tipo de armazenamento que utiliza memória flash',
        'Um sistema de entrada e saída para gráficos',
        'Um dispositivo de backup óptico',
      ],
      'correta': 1,
    },
    {
      'texto': 'Qual é o tipo de memória usada no processo de boot do sistema operacional?',
      'alternativas': [
        'RAM',
        'ROM',
        'Memória cache',
        'Memória flash',
      ],
      'correta': 1,
    },
    {
      'texto': 'Qual é a principal vantagem da memória cache?',
      'alternativas': [
        'Alta capacidade de armazenamento',
        'Maior velocidade de acesso aos dados',
        'Retenção de dados após desligamento',
        'Reduzir o consumo de energia',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que é latência de memória?',
      'alternativas': [
        'O tempo necessário para acessar um dado armazenado',
        'A quantidade de dados que podem ser armazenados',
        'O consumo de energia da memória',
        'A velocidade de transferência de dados',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual dispositivo combina funções de entrada e saída?',
      'alternativas': [
        'Disco rígido externo',
        'Impressora multifuncional',
        'Teclado',
        'Scanner',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que diferencia a memória principal da memória secundária?',
      'alternativas': [
        'A memória principal é mais barata',
        'A memória principal é mais rápida',
        'A memória secundária é volátil',
        'A memória principal utiliza discos magnéticos',
      ],
      'correta': 1,
    },
    {
      'texto': 'Qual é a função principal de um controlador de dispositivos?',
      'alternativas': [
        'Controlar o fluxo de dados entre o processador e dispositivos externos',
        'Aumentar a capacidade de processamento',
        'Realizar backup automático',
        'Armazenar arquivos temporários',
      ],
      'correta': 0,
    },
    {
      'texto': 'Por que a memória cache é mais eficiente que a RAM para determinadas tarefas?',
      'alternativas': [
        'Porque é volátil',
        'Porque tem menor latência e está mais próxima do processador',
        'Porque armazena mais dados',
        'Porque utiliza tecnologia magnética',
      ],
      'correta': 1,
    },
    {
      'texto': 'Qual dos dispositivos de entrada e saída depende diretamente de uma porta serial para funcionar?',
      'alternativas': [
        'Impressora antiga',
        'SSD',
        'Scanner moderno',
        'Memória flash',
      ],
      'correta': 0,
    },
    {
      'texto': 'O que significa o termo "ciclo de escrita" em um dispositivo de armazenamento flash?',
      'alternativas': [
        'A quantidade de dados que podem ser gravados por segundo',
        'O número de vezes que dados podem ser gravados antes de a célula se deteriorar',
        'O tempo necessário para gravar um dado',
        'A largura de banda do dispositivo',
      ],
      'correta': 1,
    },
    {
      'texto': 'O que acontece quando o barramento de entrada/saída está sobrecarregado?',
      'alternativas': [
        'A taxa de transferência de dados aumenta',
        'A comunicação entre dispositivos se torna ineficiente',
        'O processador realiza a execução de instruções mais rapidamente',
        'Dados armazenados na memória secundária são apagados',
      ],
      'correta': 1,
    },
    {
      'texto': 'Qual é a diferença entre dispositivos de armazenamento magnético e de estado sólido?',
      'alternativas': [
        'Dispositivos de estado sólido não possuem partes móveis',
        'Dispositivos magnéticos são mais rápidos que de estado sólido',
        'Dispositivos de estado sólido dependem de energia constante para manter os dados',
        'Dispositivos magnéticos não são reutilizáveis',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a principal função do DMA (Acesso Direto à Memória)?',
      'alternativas': [
        'Permitir que dispositivos de entrada/saída acessem a memória sem passar pelo processador',
        'Controlar o barramento de dados',
        'Melhorar a velocidade de acesso ao disco rígido',
        'Aumentar a largura de banda da memória principal',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é a vantagem do uso de memória flash em sistemas embarcados?',
      'alternativas': [
        'Alta capacidade de armazenamento',
        'Baixo custo em relação à RAM',
        'Capacidade de reter dados mesmo sem energia',
        'Maior velocidade de leitura/escrita em comparação ao SSD',
      ],
      'correta': 2,
    },
    {
      'texto': 'O que é o "caching write-back" em sistemas de memória?',
      'alternativas': [
        'Técnica que escreve os dados diretamente na memória principal',
        'Técnica que armazena dados temporariamente na memória cache antes de enviá-los à memória principal',
        'Uma técnica que limpa a memória cache automaticamente',
        'Um método de backup automático',
      ],
      'correta': 1,
    },
    {
      'texto': 'Por que dispositivos de armazenamento óptico, como CDs e DVDs, estão se tornando obsoletos?',
      'alternativas': [
        'Porque têm baixa capacidade de armazenamento e são mais lentos',
        'Porque dependem de memória volátil',
        'Porque possuem maior custo por gigabyte',
        'Porque não podem ser regravados',
      ],
      'correta': 0,
    },
    {
      'texto': 'Em arquiteturas modernas, qual é a função de um controlador RAID?',
      'alternativas': [
        'Aumentar a velocidade de processamento',
        'Gerenciar discos para aumentar desempenho e/ou redundância de dados',
        'Controlar o barramento de entrada/saída',
        'Realizar backup em nuvem automaticamente',
      ],
      'correta': 1,
    },
    {
      'texto': 'Quais são as principais memórias internas de um computador?',
      'alternativas': [
        'Memória cache, memória principal, discos magnéticos',
        'Memória cache, memória flash (SSD), discos magnéticos',
        'Banco de registradores, memória cache e memória principal',
        'Banco de registradores, memória cache e discos magnéticos',
      ],
      'correta': 2,
    },
    {
      'texto': 'Quais são os três parâmetros de desempenho de uma memória?',
      'alternativas': [
        'Tempo de ciclo de memória, tempo de acesso e latência',
        'Taxa de transferência, tamanho da palavra e tempo de ciclo de memória',
        'Tempo de ciclo de memória, tempo de acesso, capacidade',
        'Tempo de acesso, latência, taxa de transferência',
      ],
      'correta': 3,
    },
    {
      'texto': 'Quais são os métodos de acesso que podem ser empregados em uma memória cache?',
      'alternativas': [
        'Acesso direto e acesso sequencial',
        'Acesso aleatório e acesso associativo',
        'Acesso aleatório e Acesso direto',
        'Acesso aleatório e acesso sequencial',
      ],
      'correta': 3,
    },
    {
      'texto': 'Quais são as técnicas usadas para implementar a função de mapeamento que dita como a cache é organizada?',
      'alternativas': [
        'Direta, associativa e associativa em conjunto',
        'Indireta, associativa e associativa em conjunto',
        'Sequencial, direta, aleatória, associativa',
        'Direta, aleatória, associativa em conjunto',
      ],
      'correta': 0,
    },
    {
      'texto': 'Qual é o tipo de memória ROM que utiliza radiação ultravioleta para apagar as células?',
      'alternativas': [
        'Memória EPROM',
        'Memória PROM',
        'Memória EEPROM',
        'Memória DDR-SDRAM',
      ],
      'correta': 0,
    },
    {
      'texto': 'Como são categorizados os erros em um sistema de memória semicondutora?',
      'alternativas': [
        'Falha de barramento e falha de leitura de dados',
        'Falha permanente e falha de armazenagem de dados',
        'Erro de escrita de dados e falha de barramento',
        'Erro não permanente e falha permanente',
      ],
      'correta': 3,
    },
    {
      'texto': 'O que pode ser dizer sobre a memória SDRAM?',
      'alternativas': [
        'A SDRAM é assíncrona e isso afeta o desempenho do sistema',
        'A SDRAM é muito lenta em relação a DRAM tradicional',
        'A SDRAM pode receber ou enviar dados ao processador uma vez por ciclo de clock do barramento',
        'A SDRAM move apenas dados para fora da memória sob o controle do clock do sistema',
      ],
      'correta': 3,
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
                          backgroundColor: Colors.white,
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
                        child: _buildButton('Parar', _parar),
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
