## Prerequisites

- This script assumes you are running it on Ubuntu 20.04 or a compatible Debian-based system.
- Ensure you have sudo privileges to install packages and modify system configurations.

## Usage

1. **Download the Script**:

   Download the `nginx_setup.sh` script to your server:

   ```bash
   wget https://example.com/nginx_setup.sh
2. **Make the Script Executable**:

    Make the script executable using the following command:
    ```bash
    chmod +x nginx_setup.sh
3. **Run the Script**:

    Execute the script with sudo privileges to install Nginx and set up a server block for your domain (your_domain):
    ```bash
    sudo ./nginx_setup.sh

- Follow the prompts and enter your password if prompted.

4. **Verify Installation**:

    After running the script, verify that Nginx is installed and the server block for your domain is correctly set up:

    - Open a web browser and visit http://your_domain and http://www.your_domain. You should see the sample HTML page confirming that the server block is working.

    Check the Nginx status to ensure there are no errors:

    ```bash
    sudo systemctl status nginx
5. **Customization**:
    - Modify the script or the nginx_setup.sh file itself to customize the domain name (your_domain), server block configuration, or default index.html content.

6. **Troubleshooting**:

    - If there are any issues during installation or configuration, check the terminal output for error messages. Common issues may include permission errors or syntax errors in Nginx configuration files.