List<Map<String, dynamic>> getPerguntas() {
  return [
    // Questões fáceis
    {
      'texto': 'Qual é a principal função de um dispositivo de entrada?',
      'alternativas': [
        'Processar dados',
        'Armazenar informações',
        'Fornecer dados ao computador',
        'Transmitir dados para outros dispositivos',
      ],
      'correta': 2,
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
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
      'dificuldade': 'facil'
    },
    // Questões médias
    {
      'texto': 'Por que a memória cache é mais eficiente que a RAM para determinadas tarefas?',
      'alternativas': [
        'Porque é volátil',
        'Porque tem menor latência e está mais próxima do processador',
        'Porque armazena mais dados',
        'Porque utiliza tecnologia magnética',
      ],
      'correta': 1,
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
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
      'dificuldade': 'media'
    },
    // Questões difíceis
    {
      'texto': 'Quais são as principais memórias internas de um computador?',
      'alternativas': [
        'Memória cache, memória principal, discos magnéticos',
        'Memória cache, memória flash (SSD), discos magnéticos',
        'Banco de registradores, memória cache e memória principal',
        'Banco de registradores, memória cache e discos magnéticos',
      ],
      'correta': 2,
      'dificuldade': 'dificil'
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
      'dificuldade': 'dificil'
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
      'dificuldade': 'dificil'
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
      'dificuldade': 'dificil'
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
      'dificuldade': 'dificil'
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
      'dificuldade': 'dificil'
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
      'dificuldade': 'dificil'
    },
  ];
}
