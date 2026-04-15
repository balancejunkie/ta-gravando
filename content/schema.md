# Schema — Tá Gravando Wiki

Este wiki documenta e analisa o canal **Tá Gravando** (YouTube), apresentado por **Ítalo Sena**, com foco na série "Mande a Sua" onde o público sugere ideias de pegadinhas executadas na rua.

## Estrutura

```
ta-gravando-wiki/
├── index.md              # Catálogo principal com links e resumos
├── schema.md             # Este arquivo — convenções e estrutura
├── log.md                # Registro cronológico de ingestões
├── principios/           # Princípios de comédia identificados
│   └── <principio>.md
├── episodios/            # Uma página por episódio analisado
│   └── ep-<numero>.md
├── pranks/               # Uma página por pegadinha individual
│   └── <slug>.md
└── raw-sources/          # Transcrições originais (imutáveis)
```

## Convenções

### Páginas de Pegadinha (`pranks/`)
- **Frontmatter:** nome, episódio, timestamp, mecanismos de comédia (tags)
- **Seções:** Setup, Twist/Escalação, Reações das Vítimas, Análise
- **Links:** para episódio de origem e princípios de comédia relevantes

### Páginas de Princípio (`principios/`)
- **Descrição** do mecanismo de comédia
- **Por que funciona** — explicação psicológica/social
- **Exemplos** — links para pegadinhas que usam este princípio
- **Variações** — como o canal adapta o mesmo princípio

### Páginas de Episódio (`episodios/`)
- **Metadados:** título, número, data, duração, URL
- **Lista de pegadinhas** com links para cada uma
- **Destaques** — melhores momentos

### Wikilinks
- Use `[[double brackets]]` para todas as referências internas
- Format: `[[pranks/slug|Nome da Pegadinha]]`
- Tags: `#principio/nome` para mecanismos de comédia

### Idioma
- Conteúdo em português brasileiro
- Termos técnicos de comédia em inglês quando necessário (ex: "deadpan", "callback")
