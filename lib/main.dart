import 'package:flutter/material.dart';

void main() {
  runApp(const QuemQuerSerEngenheiro());
}

class QuemQuerSerEngenheiro extends StatelessWidget {
  const QuemQuerSerEngenheiro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quem Quer Ser um Engenheiro?',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quem Quer Ser um Engenheiro?')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TelaPerguntas()),
            );
          },
          child: const Text('Começar Jogo'),
        ),
      ),
    );
  }
}

class TelaPerguntas extends StatefulWidget {
  const TelaPerguntas({Key? key}) : super(key: key);

  @override
  State<TelaPerguntas> createState() => _TelaPerguntasState();
}

class _TelaPerguntasState extends State<TelaPerguntas> {
  // Dados do jogo: perguntas organizadas por etapas
  final List<List<Map<String, dynamic>>> etapas = [
    // Etapa 1
    [
      {
        "pergunta": "O que é a ALU?",
        "opcoes": [
          "Unidade Lógica e Aritmética",
          "Unidade de Memória",
          "Processador",
          "Unidade de Controle"
        ],
        "resposta_correta": 0,
      },
      {
        "pergunta": "O que é uma memória RAM?",
        "opcoes": [
          "Memória secundária",
          "Memória de acesso rápido",
          "Memória não volátil",
          "Memória de armazenamento permanente"
        ],
        "resposta_correta": 1,
      },
      // Adicione mais perguntas da Etapa 1...
    ],
    // Etapa 2
    [
      {
        "pergunta": "O que é um registrador?",
        "opcoes": [
          "Um tipo de processador",
          "Uma memória interna rápida",
          "Um controlador de barramento",
          "Uma placa de rede"
        ],
        "resposta_correta": 1,
      },
      // Adicione perguntas da Etapa 2...
    ],
    // Etapa Final
    [
      {
        "pergunta": "Quem criou a arquitetura von Neumann?",
        "opcoes": [
          "Alan Turing",
          "John von Neumann",
          "Ada Lovelace",
          "Niklaus Wirth"
        ],
        "resposta_correta": 1,
      },
    ],
  ];

  int etapaAtual = 0; // Controla a etapa atual
  int perguntaAtual = 0; // Índice da pergunta dentro da etapa
  int pontuacao = 0; // Pontuação acumulada
  int valorPergunta = 1000; // Valor inicial das perguntas
  int? respostaSelecionada; // Índice da resposta selecionada
  int ajudasRestantes = 3; // Número de ajudas disponíveis

  void usarAjuda() {
    if (ajudasRestantes > 0) {
      setState(() {
        ajudasRestantes--;
        // Implementação de ajuda: remove opções incorretas visualmente
      });
    }
  }

  void pararJogo() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultados(
          pontuacao: pontuacao,
          mensagem: 'Você optou por parar!',
        ),
      ),
    );
  }

  void verificarResposta() {
    setState(() {
      if (respostaSelecionada == etapas[etapaAtual][perguntaAtual]["resposta_correta"]) {
        pontuacao += valorPergunta;
        proximaPergunta();
      } else {
        // Penalidade: metade do valor acumulado
        pontuacao = (pontuacao / 2).round();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TelaResultados(
              pontuacao: pontuacao,
              mensagem: 'Você errou!',
            ),
          ),
        );
      }
    });
  }

  void proximaPergunta() {
    respostaSelecionada = null; // Reseta a seleção
    perguntaAtual++;

    if (perguntaAtual >= etapas[etapaAtual].length) {
      if (etapaAtual == etapas.length - 1) {
        // Final do jogo
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TelaResultados(
              pontuacao: pontuacao,
              mensagem: 'Parabéns, você venceu!',
            ),
          ),
        );
      } else {
        // Próxima etapa
        etapaAtual++;
        perguntaAtual = 0;
        valorPergunta *= 10; // Aumenta o valor da pergunta
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = etapas[etapaAtual][perguntaAtual];

    return Scaffold(
      appBar: AppBar(
        title: Text('Etapa ${etapaAtual + 1} - Pergunta ${perguntaAtual + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              pergunta["pergunta"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(pergunta["opcoes"].length, (index) {
              return ListTile(
                title: Text(pergunta["opcoes"][index]),
                leading: Radio<int>(
                  value: index,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: respostaSelecionada != null ? verificarResposta : null,
              child: const Text('Confirmar'),
            ),
            ElevatedButton(
              onPressed: pararJogo,
              child: const Text('Parar'),
            ),
            if (ajudasRestantes > 0)
              ElevatedButton(
                onPressed: usarAjuda,
                child: Text('Usar Ajuda ($ajudasRestantes restantes)'),
              ),
          ],
        ),
      ),
    );
  }
}

class TelaResultados extends StatelessWidget {
  final int pontuacao;
  final String mensagem;

  const TelaResultados({Key? key, required this.pontuacao, required this.mensagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mensagem,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sua pontuação final: $pontuacao',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar ao Início'),
            ),
          ],
        ),
      ),
    );
  }
}
