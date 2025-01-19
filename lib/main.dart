import 'package:flutter/material.dart';

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
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Instruções'),
                    content: const Text(
                      'Responda as perguntas corretamente e use as ajudas quando necessário. '
                      'O objetivo final é acumular conhecimento e passar na matéria!',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Entendi!'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Instruções'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sair'),
            ),
          ],
        ),
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
    // Adicione mais perguntas...
  ];

  int perguntaAtual = 0;
  int pontuacao = 0;
  int pulosRestantes = 3;

  void responder(int index) {
    if (index == perguntas[perguntaAtual]['correta']) {
      setState(() {
        pontuacao += 1000 * (perguntaAtual + 1);
        perguntaAtual++;
      });
    } else {
      _mostrarDialogo('Errou!', 'Você perdeu. Pontuação final: $pontuacao');
    }
  }

  void pular() {
    if (pulosRestantes > 0) {
      setState(() {
        perguntaAtual++;
        pulosRestantes--;
      });
    } else {
      _mostrarDialogo('Sem pulos!', 'Você já usou todos os seus pulos.');
    }
  }

  void _mostrarDialogo(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (perguntaAtual >= perguntas.length) {
      return TelaFinal(pontuacao: pontuacao);
    }

    final pergunta = perguntas[perguntaAtual];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pergunta Atual'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pergunta ${perguntaAtual + 1}: ${pergunta['texto']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ...List.generate(pergunta['alternativas'].length, (index) {
              return ElevatedButton(
                onPressed: () => responder(index),
                child: Text(pergunta['alternativas'][index]),
              );
            }),
            const SizedBox(height: 20),
            Text('Pulos restantes: $pulosRestantes'),
            ElevatedButton(
              onPressed: pular,
              child: const Text('Pular'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela Final
class TelaFinal extends StatelessWidget {
  final int pontuacao;

  const TelaFinal({super.key, required this.pontuacao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Parabéns!',
              style: TextStyle(fontSize: 24),
            ),
            Text('Sua pontuação final foi: $pontuacao'),
            ElevatedButton(
              onPressed: () {
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
      ),
    );
  }
}
