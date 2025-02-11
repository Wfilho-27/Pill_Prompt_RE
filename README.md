# Pill Prompt

## 📌 Resumo
O Pill Prompt foi desenvolvido para auxiliar profissionais de saúde no gerenciamento da administração de medicamentos em Instituições de Longa Permanência para Idosos (ILPIs). O dispositivo armazena os medicamentos de forma organizada e emite alertas visuais e sonoros no horário programado para a medicação. O projeto conta com uma interface intuitiva desenvolvida na Godot, permitindo o controle eficiente dos usuários e especificação de doses. A comunicação com o circuito externo é realizada pelo microcontrolador ESP32, responsável pela ativação dos alarmes e LEDs de indicação.

## 🔑 Palavras-chave
Gaveteiro, Godot, Interface Virtual, Saúde, Assistência Farmacêutica, Tecnologia Assistiva, Programação.

## 🎯 Objetivo
Desenvolver uma solução de baixo custo e acessível para melhorar a administração de medicamentos em ILPIs, reduzindo erros e otimizando o processo de medicação por meio da tecnologia assistiva.

## 🛠 Tecnologias Utilizadas
- **Godot Engine**: Desenvolvimento da interface virtual interativa.
- **ESP32**: Microcontrolador responsável pela ativação de alertas e comunicação com a interface.
- **Autodesk Tinkercad**: Simulação do circuito eletrônico antes da montagem física.
- **Impressão 3D**: Produção do compartimento de proteção do circuito.
- **Wi-Fi e Bluetooth**: Comunicação entre o hardware e a interface virtual.

## 📌 Funcionalidades
✅ Interface interativa para gerenciamento de usuários e doses.<br>
✅ Alarmes visuais e sonoros no horário programado para medicação.<br>
✅ Compartimentos organizados para melhor armazenamento dos medicamentos.<br>
✅ Possibilidade de integração com TV Box para acessibilidade em diferentes dispositivos.<br>
✅ Sistema de adição de pacientes e personalização da agenda.<br>
✅ Compatível com Linux, Windows e Android.<br>

## 🔧 Como Funciona
1. **Adição de Pacientes**: Os profissionais de saúde inserem os dados do paciente e suas respectivas medicações.
2. **Programação dos Horários**: O sistema permite configurar os horários para administração dos medicamentos.
3. **Alerta Sonoro e Visual**: No horário programado, o ESP32 ativa um LED correspondente ao compartimento do medicamento e um buzzer emite um alerta sonoro.
4. **Confirmação de Medicação**: O profissional confirma a administração do medicamento pressionando um botão, desativando o alarme.

## 🚀 Etapas de Desenvolvimento
- **Pesquisa e Planejamento**: Estudos sobre a administração de medicamentos em ILPIs e revisão de projetos semelhantes.
- **Desenvolvimento da Interface**: Criada na Godot Engine para facilitar o gerenciamento dos pacientes e seus medicamentos.
- **Desenvolvimento do Hardware**: Utilização do ESP32 e testes com componentes eletrônicos (LEDs, buzzer, botões físicos).
- **Testes e Validação**: Testes de desempenho dos componentes e avaliação da usabilidade do sistema.

## 📊 Resultados e Desempenho
Os testes demonstraram que o sistema apresenta:
- **Tempo médio de resposta dos LEDs**: 1 segundo
- **Luminosidade dos LEDs**: 300 lux
- **Volume máximo do Buzzer**: 85 dB
- **Tempo médio de processamento do ESP32**: 1 segundo

Esses resultados garantem um sistema eficiente e confiável para o gerenciamento de medicamentos em ILPIs.

## 📅 Futuro do Projeto
- Implementação de um banco de dados para melhor gerenciamento dos pacientes.
- Melhorias na comunicação entre a interface e o hardware.
- Integração com dispositivos móveis para alertas remotos.

## 🤝 Contribuidores
O projeto foi idealizado e desenvolvido por quatro estudantes de eletrônica do Instituto Federal de Educação, Ciência e Tecnologia do Piauí (IFPI), no Laboratório de Robótica, Automação e Sistemas Inteligentes (LABIRAS).

## 📜 Licença
Este projeto está licenciado sob a licença **MIT**, permitindo seu uso, modificação e distribuição.

---
🔗 **Contato**: Caso tenha dúvidas ou sugestões, sinta-se à vontade para abrir uma issue ou entrar em contato com os desenvolvedores!

