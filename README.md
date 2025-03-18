# BHostDiscovery 🚀

## Author
[Boni Yeamin]  
Email: boniyeamin@gmail.com  
GitHub: [https://github.com/boniyeamin](https://github.com/boniyeamincse)  
LinkedIn: [https://www.linkedin.com/in/boniyeamin/](https://www.linkedin.com/in/boniyeamin/)

## Overview
BHostDiscovery is a Bash script designed to scan a specified network for live hosts using Nmap. The results are stored in a structured directory format for easy access and analysis.

## Features ✨
- Scans multiple subnets within a specified network.
- Displays a colorful banner before scanning.
- Provides a menu for user interaction.
- Saves live host results in organized directories.
- Password protection to restrict access.

## Usage 📋
1. Clone the repository:
    ```sh
    git clone https://github.com/boniyeamincse/B-hostdiscovery.git
    cd bhostdiscovery
    ```

2. Make the script executable:
    ```sh
    chmod +x scan_hosts.sh
    ```

3. Run the script:
    ```sh
    ./scan_hosts.sh
    ```

4. Enter the password when prompted (default password: `care@1718`).

5. Follow the on-screen menu to select your desired option.

## Menu Options 📜
1. **Run the Dependency (All Types Of Linux OS)**: Installs necessary dependencies for the script.
2. **Submit your IP block**: Allows you to specify the IP block to scan.
3. **Run Again**: Restarts the scanning process.
4. **Exit Script**: Exits the script.

## Future Development 🔮
- **Enhanced Error Handling**: Improve error handling to manage unexpected issues during scanning.
- **Customizable Scan Range**: Allow users to specify custom subnet ranges for scanning.
- **Detailed Reporting**: Generate detailed reports of the scan results, including timestamps and host details.
- **Parallel Scanning**: Optimize the script to perform parallel scanning for faster results.
- **Cross-Platform Support**: Ensure compatibility with different operating systems, including macOS and Windows.
- **User Authentication**: Add user authentication to restrict access to the script.

## License 📄
This project is licensed under the MIT License.
