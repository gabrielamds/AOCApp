import 'dart:async';
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
    // Adicione mais perguntas...
  ];

  int perguntaAtual = 0;
  int pontuacao = 0;
  int pulosRestantes = 3;
  int segundosRestantes = 45;
  bool bloqueio = false;
  late Timer timer;

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
      });
      _mostrarDialogo(
        'Resposta Correta!',
        'Você ganhou R\$${pontuacao}!',
        continuar: true,
      );
    } else {
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
          children: [
            Text(
              pergunta['texto'],
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ...List.generate(pergunta['alternativas'].length, (index) {
              return ElevatedButton(
                onPressed: () => _responder(index),
                child: Text(pergunta['alternativas'][index]),
              );
            }),
            const SizedBox(height: 20),
            Text('Tempo restante: $segundosRestantes segundos'),
          ],
        ),
      ),
    );
  }
}
