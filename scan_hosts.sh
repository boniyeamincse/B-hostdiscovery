#!/bin/bash

# Author: Boni Yeamin

# Password prompt
PASSWORD="care@1718"
read -sp "Enter password: " input_password
echo
if [ "$input_password" != "$PASSWORD" ]; then
    echo "Incorrect password. Exiting."
    exit 1
fi

# Define base directory for storing results
BASE_DIR="./scan_results"
mkdir -p "$BASE_DIR"

# Function to scan a subnet
scan_network() {
    local SUBNET=$1
    if [[ -z "$NETWORK" ]]; then
        echo "Network not set. Please enter an IP block in the menu first."
        return 1
    fi

    echo "Scanning $NETWORK..."

    # Create a folder for results
    SUBNET_DIR="$BASE_DIR/${NETWORK//\//_}"  # Replace '/' in CIDR with '_'
    mkdir -p "$SUBNET_DIR"

    # File to store live hosts
    LIVE_HOSTS_FILE="$SUBNET_DIR/live_hosts.txt"
    > "$LIVE_HOSTS_FILE"  # Clear previous results

    # Use Nmap to discover live hosts
    nmap -sn "$NETWORK" -oG - | awk '/Up$/{print $2}' > "$LIVE_HOSTS_FILE"

    echo "Live hosts saved in $LIVE_HOSTS_FILE"
}

# Function to display the banner
display_banner() {
    echo -e "\033[32m"  # Set text color to green
    echo "   _____   __   .__     __    ________                           "
    echo "  /  _  \ |  | _|__|   |__|  /  _____/______  ____  __ ________  "
    echo " /  /_\  \|  |/ /  |   |  | /   \  __\_  __ \/  _ \|  |  \____ \ "
    echo "/    |    \    <|  |   |  | \    \_\  \  | \(  <_> )  |  /  |_> >"
    echo "\____|__  /__|_ \__/\__|  |  \______  /__|   \____/|____/|   __/ "
    echo "        \/     \/  \______|         \/                   |__|boni"
    echo -e "\033[0m"  # Reset text color to default
}

# Main function
main() {
    if [[ -z "$NETWORK" ]]; then
        echo "Please set the IP block first from the menu."
        return
    fi

    display_banner
    scan_network "$NETWORK"

    echo "✅ Scanning completed!"

    # Ask user if they want to run the script again
    run_again_prompt
}

# Function to confirm running the script again
run_again_prompt() {
    read -p "Do you want to run the script again? (yes/no): " answer
    if [[ "$answer" == "yes" ]]; then
        main
    else
        echo "Exiting script."
        exit 0
    fi
}

# Function to display menu and handle user input
display_menu() {
    while true; do
        echo "Select an option:"
        echo "1. Check Dependencies"
        echo "2. Submit your IP block"
        echo "3. Run Scanner"
        echo "4. Exit Script"
        read -p "Enter your choice: " choice

        case $choice in
            1)
                echo "Checking dependencies..."
                if ! command -v nmap &>/dev/null; then
                    echo "nmap not found. Installing..."
                    sudo apt-get install -y nmap
                else
                    echo "All dependencies are installed."
                fi
                ;;
            2)
                read -p "Enter the IP block to scan (e.g., 10.24.0.0/24): " NETWORK
                if [[ -z "$NETWORK" ]]; then
                    echo "Invalid input. Please enter a valid IP block."
                fi
                ;;
            3)
                main
                ;;
            4)
                echo "Exiting script."
                exit 0
                ;;
            *)
                echo "Invalid choice, please try again."
                ;;
        esac
    done
}

# Start menu
display_menu
