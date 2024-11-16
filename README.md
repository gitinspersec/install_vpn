# Gerenciador de Configuração do WireGuard

Este script automatiza o processo de instalação e configuração do WireGuard, incluindo a movimentação do arquivo de configuração para o diretório correto, verificação de pré-requisitos e ativação da interface WireGuard.

## Pré-requisitos
Antes de usar o script, certifique-se de que:

- Você está usando uma distribuição Linux baseada em Debian (como Ubuntu) com o gerenciador de pacotes `apt`.
- Você tem privilégios de superusuário (root) ou acesso ao comando `sudo`.
- O arquivo de configuração do WireGuard (`wg-conf-1.conf`) está localizado na mesma pasta que o script.

## Instalação e Uso

1. **Clone ou copie o script para o seu ambiente local**
   
   Certifique-se de que o script e o arquivo de configuração (`wg-conf-1.conf`) estejam no mesmo diretório.

2. **Torne o script executável**

   Antes de executar o script pela primeira vez, você precisa dar permissão de execução. Execute o seguinte comando no terminal:

   ```bash
   chmod +x run.sh
   ```

3. **Execute o script**

   Execute o script com o seguinte comando:

   ```bash
   bash ./run.sh
   ```

   Durante a execução, o script irá:

   - Verificar se o WireGuard já está instalado e instalá-lo caso necessário.
   - Criar o diretório `/etc/wireguard` se ele não existir.
   - Substituir o arquivo `wg-conf-1.conf` existente no diretório `/etc/wireguard`, caso já exista.
   - Mover o arquivo `wg-conf-1.conf` para `/etc/wireguard`.
   - Ativar a interface WireGuard usando `wg-quick up`.
   - Exibir o status do WireGuard.

## Mensagens de Log

O script exibe mensagens claras para cada etapa do processo, como:

- Confirmação da instalação do WireGuard.
- Criação do diretório `/etc/wireguard` (se necessário).
- Substituição de arquivos de configuração existentes.
- Status da ativação do WireGuard.
"""