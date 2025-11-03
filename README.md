# 🌐  Infraestrutura RDS PostgreSQL com Terraform - Fase 3

Este repositório provisiona e gerencia um **banco de dados PostgreSQL no Amazon RDS**, utilizando **Terraform** como ferramenta de IaC (Infraestrutura como Código).  
O projeto segue boas práticas de modularização e versionamento.

---

## 🏗️ Visão Geral da Arquitetura

A infraestrutura criada contém os seguintes componentes:

- **Amazon RDS (PostgreSQL):** Instância gerenciada de banco de dados.
- **Subnet Group:** Agrupa subnets privadas para hospedar o banco.
- **Security Group:** Controla o tráfego permitido para a instância.
- **VPC (externa ou referenciada):** Rede onde o RDS será implantado.
- **Terraform Backend (S3 + DynamoDB):** Armazenamento e lock do state remoto.

## 📋 Índice

- [Infraestrutura (IaC) com Terraform](#-infraestrutura-iac-com-terraform)


### 🏗️ Infraestrutura (IaC) com Terraform

A infraestrutura do projeto é provisionada utilizando Terraform,
organizada de forma modular para facilitar a manutenção e o reuso dos componentes.

### 📁 Estrutura

```plaintext
infra-rds-postgress/
├── modules/          
│   ├── vpc/                # Criação da VPC, subnets e rotas
│   ├── rds/                # Instância do banco de dados RDS PostgreSQL com subnets privadas
│   └── security_group/     # Regras de segurança e grupos de acesso
├── main.tf             # Arquivo principal que integra os módulos para o ambiente de produção
```

Cada módulo representa um componente independente da infraestrutura, permitindo o versionamento e a escalabilidade da
arquitetura.
O diretório prod/ contém a configuração do ambiente produtivo, referenciando os módulos necessários para provisionar
toda a stack AWS.


## 🔗 Repositórios Relacionados — Fase 3

A arquitetura do **Gerenciador de Oficina — Fase 3** é composta por múltiplos módulos independentes, cada um versionado em um repositório separado para facilitar a manutenção e o CI/CD.

| Módulo | Descrição | Repositório                                                                                                             |
|:-------|:-----------|:------------------------------------------------------------------------------------------------------------------------|
| 🧱 **Core Application** | Aplicação principal responsável pelas regras de negócio, APIs REST e integração com os demais módulos. | [gerenciador-oficina-core-fase-3](https://github.com/thomaserick/gerenciador-oficina-core-fase-3)                       |
| ⚡ **Lambda Functions** | Conjunto de funções *serverless* para processamento assíncrono, notificações e automações event-driven. | [gerenciador-oficina-lambda-fase-3](https://github.com/thomaserick/gerenciador-oficina-lambda-fase-3)       |
| ☸️ **Kubernetes Infrastructure** | Infraestrutura da aplicação no Kubernetes, incluindo manifests, deployments, ingress e autoscaling. | [gerenciador-oficina-k8s-infra-fase-3](https://github.com/thomaserick/gerenciador-oficina-k8s-infra-fase-3) |
| 🗄️ **Database Infrastructure** | Infraestrutura do banco de dados gerenciado (RDS PostgreSQL), versionada e automatizada via Terraform. | [gerenciador-oficina-db-infra-fase-3](https://github.com/thomaserick/gerenciador-oficina-db-infra-fase-3)  |

> 🔍 Cada repositório é autônomo, mas integra-se ao **Core** por meio de pipelines e configurações declarativas (Terraform e CI/CD).


