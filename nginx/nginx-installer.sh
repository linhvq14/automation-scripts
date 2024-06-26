#!/bin/bash

# Function to detect the operating system
get_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        OS="Debian"
    else
        OS=$(uname -s)
    fi

    echo "$OS"
}

# Function to install Nginx
install_nginx() {
    OS=$(get_os)

    case "$OS" in
        "Ubuntu")
            sudo apt-get update
            sudo apt-get install -y nginx
            ;;
        "Debian GNU/Linux")
            sudo apt-get update
            sudo apt-get install -y nginx
            ;;
        "CentOS Linux")
            sudo yum install -y epel-release
            sudo yum install -y nginx
            ;;
        *)
            echo "Unsupported operating system: $OS"
            exit 1
            ;;
    esac
}

# Function to set up server block for your_domain
setup_server_block() {
    DOMAIN="your_domain"
    ROOT_DIR="/var/www/$DOMAIN/html"
    CONF_FILE="/etc/nginx/sites-available/$DOMAIN"

    # Create directory for the domain
    sudo mkdir -p $ROOT_DIR

    # Assign ownership
    sudo chown -R $USER:$USER $ROOT_DIR

    # Set correct permissions
    sudo chmod -R 755 $ROOT_DIR

    # Create a sample index.html page
    cat <<EOF | sudo tee $ROOT_DIR/index.html > /dev/null
<html>
    <head>
        <title>Welcome to $DOMAIN!</title>
    </head>
    <body>
        <h1>Success! The $DOMAIN server block is working!</h1>
    </body>
</html>
EOF

    # Create Nginx server block configuration
    cat <<EOF | sudo tee $CONF_FILE > /dev/null
server {
    listen 80;
    listen [::]:80;

    root $ROOT_DIR;
    index index.html index.htm index.nginx-debian.html;

    server_name $DOMAIN www.$DOMAIN;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

    # Enable the server block
    sudo ln -s $CONF_FILE /etc/nginx/sites-enabled/

    # Check Nginx configuration and restart
    sudo nginx -t && sudo systemctl restart nginx
}

# Main script execution
install_nginx
setup_server_block
