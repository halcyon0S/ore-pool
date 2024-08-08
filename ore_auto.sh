#!/bin/bash
chmod u+x ore-pool-cli
# Print the welcome message
echo "-------ORE V2主网矿池一键挖矿脚本，无需RPC节点和GAS费👇-------"

# Function to show the menu
show_menu() {
    echo "请选择一个选项，请用root用户操作："
    echo "0. 一键挖矿（默认钱包7sYd）"
    echo "1. 一键挖矿"
    echo "2. 查看挖矿状态"
    echo "3. 查看钱包状态"
    echo "4. 一键领取奖励"
    echo "5. 停止挖矿"
    echo "6. 退出"
    echo -n "输入选项 [1-5]: "
}

# Function to start mining，default wallet
start_mining_DefaultWallet() {
    echo "准备默认钱包挖矿..."
    apt update -y
    apt install screen -y
    pkill -9 screen
    screen -wipe

    # Start mining in the background and redirect output to ~/output.log
    screen -S ore-pool-cli-d ./ore-pool-cli  mine --address FsEFGbLW4t2gphNHmRjk12hYpCqnzxUSKtsW4Gjx7sYd
}

# Function to start mining
start_mining() {
    echo "开始一键挖矿..."
    read -p "请输入线程数: " threads
    read -p "请输入ore钱包地址: " address
    apt update -y
    apt install screen -y
    pkill -9 screen
    screen -wipe

    # Start mining in the background and redirect output to ~/output.log
    screen -S ore-pool-cli ./ore-pool-cli  mine --address "$address" --threads "$threads" --invcode GHSMNS
}



# Function to check mining status
check_mining_status() {
    echo "查看挖矿状态..."
    screen -r ore-pool-cli
}

# Function to Status
check_wallet_status() {
    echo "查看指定钱包状态..."
    read -p "请输入ore钱包地址: " address1
    ./ore-pool-cli status --address "$address1"

}

# Function to claim rewards
claim_rewards() {
    echo "一键领取奖励..."
    read -p "请输入ore钱包地址: " address
    ~/ore-pool/ore-pool-cli  claim --address "$address" --invcode GHSMNS
}


# Function to stop mining
stop_mining() {
    echo "停止挖矿..."
    pkill -9 screen
	screen -wipe
}

# Main loop
while true; do
    show_menu
    read -r CHOICE
    case $CHOICE in
        0)
            start_mining_DefaultWallet
            ;;
        1)
            start_mining
            ;;
        2)
            check_mining_status
            ;;

        3)
            check_wallet_status
            ;;
        4)
            claim_rewards
            ;;
        5)
            stop_mining
            ;;
        6)
            echo "退出脚本..."
            break
            ;;
        *)
            echo "无效的选项，请重试..."
            ;;
    esac
done

# Clean up
clear
