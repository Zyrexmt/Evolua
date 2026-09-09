# Evolua 🌌

Aplicativo mobile desenvolvido em Flutter como projeto teste da modalidade **#08 – Desenvolvimento de Aplicativos Móveis** (WorldSkills — Seletiva Estadual do Paraná), Módulo A2.

## 📱 Sobre o projeto

Aplicativo de saúde mental e aprendizado, com sistema de login autenticado, desafios diários consumidos via API externa e histórico de desafios concluídos por usuário (multiusuário no mesmo dispositivo).

## 🖥️ Telas

- **Splash** — verificação de conectividade com a API (`GET /status`), navegação automática após ~3s em caso de sucesso, popup + encerramento em caso de falha
- **Login** — autenticação via API (`POST /login`), botão habilitado apenas com e-mail e senha preenchidos, token salvo de forma persistente (validade de 3 min de inatividade), login automático em acessos subsequentes
- **Home** — resumo de progresso ("Desafio X de 5"), busca de desafio via API (`GET /desafio/<id>`) com `Authorization: Bearer <token>`, navegação para "Sobre" e "Desafios Concluídos", logout
- **Desafios Concluídos** — histórico local por usuário (dados isolados entre usuários diferentes no mesmo dispositivo), categorias (Foco, Emoções, Disciplina, Social), progresso geral (X de 30)
- **Sobre** — textos institucionais fixos sobre o propósito do app

## 🔌 Integração com API

| Endpoint | Método | Descrição |
|---|---|---|
| `/seletiva_pr_a2/status` | GET | Health check do servidor |
| `/seletiva_pr_a2/users` | GET / POST | Listagem e cadastro de usuários |
| `/seletiva_pr_a2/login` | POST | Autenticação (retorna token) |
| `/seletiva_pr_a2/desafios/<id_desafio>` | GET | Retorna um desafio (requer token) |

## 🎨 Paleta de cores

| Cor | Hex |
|---|---|
| Fundo claro | `#F7F7F7` |
| Fundo secundário | `#EDEDED` |
| Azul claro | `#AED6F1` |
| Verde água | `#A2DED0` |
| Texto/escuro | `#333333` |

## ⚙️ Tecnologias

- Flutter
- Consumo de API REST (requisições GET/POST autenticadas)
- Armazenamento local persistente (token e histórico de desafios por usuário)

## 📦 Requisitos técnicos atendidos

- Orientação adaptável (retrato/paisagem conforme o dispositivo)
- Telas em tela cheia, sem ícones padrão do sistema
- Redirecionamento automático para login em falhas de autenticação/token expirado
- Alinhamento de texto justificado em todas as telas
- Logo limitada a 20% da largura da tela nos cabeçalhos

## ▶️ Como executar

```bash
flutter pub get
flutter run
```

## 📝 Entrega

Desenvolvimento versionado via Git, com commits organizados por tela/funcionalidade.
