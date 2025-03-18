#!/bin/bash

# Author: [Your Name]

# Password prompt
PASSWORD="care@1718"
read -sp "Enter password: " input_password
echo
if [ "$input_password" != "$PASSWORD" ]; then
    echo "Incorrect password. Exiting."
    exit 1
fi

# Function to scan a subnet
scan_network() {
    SUBNET=$1
    echo "Scanning $NETWORK.$SUBNET.0/24..."

    # Create a folder for the subnet
    SUBNET_DIR="$BASE_DIR/$NETWORK.$SUBNET"
    mkdir -p "$SUBNET_DIR"

    # File to store live hosts
    LIVE_HOSTS_FILE="$SUBNET_DIR/live_hosts.txt"
    > "$LIVE_HOSTS_FILE"  # Clear previous results

    # Use Nmap to discover live hosts
    nmap -sn "$NETWORK.$SUBNET.0/24" -oG - | awk '/Up$/{print $2}' > "$LIVE_HOSTS_FILE"

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

    # Change color after 5 seconds
    sleep 5
    echo -e "\033[31m"  # Set text color to red
    echo "   _____   __   .__     __    ________                           "
    echo "  /  _  \ |  | _|__|   |__|  /  _____/______  ____  __ ________  "
    echo " /  /_\  \|  |/ /  |   |  | /   \  __\_  __ \/  _ \|  |  \____ \ "
    echo "/    |    \    <|  |   |  | \    \_\  \  | \(  <_> )  |  /  |_> >"
    echo "\____|__  /__|_ \__/\__|  |  \______  /__|   \____/|____/|   __/ "
    echo "        \/     \/  \______|         \/                   |__|boni"
    echo -e "\033[0m"  # Reset text color to default
}

# Function to display menu and handle user input
display_menu() {
    echo "Select an option:"
    echo "1. Run the Dependency (All Types Of Linux OS)"
    echo "2. Submit your IP block"
    echo "3. Run Again"
    echo "4. Exit Script"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo "Running dependency installation..."
            # Add dependency installation commands here
            ;;
        2)
            read -p "Enter the IP block to scan: " NETWORK
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
            display_menu
            ;;
    esac
}

# Main function
main() {
    display_banner

    # Scan multiple subnets (modify range as needed)
    for SUBNET in {1..10}; do  # Adjust range as needed
        scan_network $SUBNET &
    done

    wait  # Wait for all background jobs to finish
    echo "✅ Scanning completed!"

    # Exit with code 3
    exit 3
}

# Display menu to the user
display_menu