#!/bin/bash
# Copy Write: edutechnolearning@gmail.com, info@smarttechfunda.com

# This script installs java, epel repo, Jenkins and Nginx.

exit_script(){
   exit $1
}

check_required_packages(){
   rpm -qi wget > /dev/null
   if [ $? -ne 0 ];then
       echo "The wget package is not installed."
       echo "Install wget package and re-run this script."
       exit_script 1
   fi
}

service_enable_start_status(){
    service=$1
    systemctl enable $service
    if [ $? -ne 0 ];then
        echo "Failed to enable the $service service."
        echo "Run the journalctl -ex command and check the logs."
        exit_script 1
    fi
    systemctl start  $service
    if [ $? -ne 0 ];then
        echo "Failed to start the $service service."
        echo "Run the journalctl -ex command and check the logs."
        exit_script 1
    fi
    systemctl status $service
}

# This function installs the epel, java.
install_required_packages(){
   rpm -qi epel-release
   if [ $? -ne 0 ];then
       echo "Installing epel repo..."
       dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
       if [ $? -eq 0 ];then
           echo "Successfully install epel repo."
           rpm -qa epel-release
       else
           echo "Failed to install epel repo."
           exit_script 1
       fi
   fi

   rpm -qi java-11-openjdk
   if [ $? -ne 0 ];then
       echo "Installing java-11-openjdk..."
       yum install -y java-11-openjdk
       if [ $? -eq 0 ];then
           echo "Successfully install java-11-openjdk."
           rpm -qa epel-release
       else
           echo "Failed to install java-11-openjdk."
           exit_script 1
       fi
   fi
}

jenkins_install_configure(){
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
    if [ $? -ne 0 ];then
        echo "Failed to download jenkins.repo file."
        exit_script 1
    fi

    rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
    if [ $? -ne 0 ];then
        echo "Failed to import Jenkins key."
        exit_script 1
    fi

    yum install jenkins -y
    if [ $? -eq 0 ];then
        echo "Successfully installed jenkins."
    else
        echo "Failed to installed jenkins."
        exit_script 1
    fi

    service_enable_start_status jenkins.service

    firewall-cmd --add-port=8080/tcp --permanent
    if [ $? -eq 0 ];then
        echo "Enabled the jenkins port in firewall."
    else
        echo "Failed to enabled jenkins port in firewall."
        echo "Flush the firewall using command 'iptables -F'."
        echo "OR run the following manually."
        echo "firewall-cmd --add-port=8080/tcp --permanent"
        echo "firewall-cmd --reload"
    fi
    firewall-cmd --reload
}

nginx_install(){
    sudo cp ../config/nginx.repo /etc/yum.repos.d/nginx.repo
    if [ ! -f /etc/yum.repos.d/nginx.repo ];then
        echo "The file nginx.repo not exit on path /etc/yum.repos.d/."
        echo "Copy nginx.repo file from config folder to /etc/yum.repos.d/ path manually."
        echo "Install nginx using command 'yum install -y nginx'"
    fi
    yum install nginx -y
    if [ $? -ne 0 ];then
        echo "Failed to install nginx"
        exit_script 1
    fi

    service_enable_start_status nginx

    firewall-cmd --permanent --zone=public --add-service=http
    if [ $? -eq 0 ];then
        echo "Enabled the nginx port in firewall."
    else
        echo "Failed to enabled nginx port in firewall."
        echo "Flush the firewall using command 'iptables -F'."
        echo "OR run the following manually."
        echo "firewall-cmd --permanent --zone=public --add-service=http"
        echo "firewall-cmd --reload"
    fi
    firewall-cmd --reload
    setsebool -P httpd_can_network_connect 1
    if [ $? -ne 0 ];then
        echo "Failed to enabled selinux permission."
        echo "Run the following command manually to enable the selinux permission."
        echo "setsebool -P httpd_can_network_connect 1"
    else
        echo "Successfully enabled the selinux permission."
    fi
}

nginx_configure(){
    sudo cp ../config/jenkins.conf /etc/nginx/conf.d/jenkins.conf
    if [ ! -f /etc/nginx/conf.d/jenkins.conf ];then
        echo "The jenkins.conf file not exit on /etc/nginx/conf.d/jenkins.conf path."
        echo "Copy jenkins.conf file from config folder to /etc/nginx/conf.d/jenkins.conf path manually."
    fi

    sudo sed  -i "s/listen       80 default_server;/listen       80;/g" /etc/nginx/nginx.conf
    if [ ! -f /etc/nginx/nginx.conf ];then
        echo "The /etc/nginx/nginx.conf file is not exist."
        exit_script 1
    fi
    systemctl restart nginx
    if [ $? -ne 0 ];then
        echo "Failed to restart nginx service."
        echo "Run the command 'journalctl -xe' and check the logs."
    else
        systemctl status nginx
        echo "Use the following URL and configure Jenkins."
        echo "http://<IP>"
        echo "IP: Enter the ip of the Jenkins instance."
    fi
}

#####Main####

check_required_packages
install_required_packages
jenkins_install_configure
nginx_install
nginx_configure