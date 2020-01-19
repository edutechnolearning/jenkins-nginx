# jenkins-nginx
=======================================================

# Note: 
The jenkins-nginx-config script works on CentOS 8 and Ubuntu 18.04 only.
If Jenkins and Nignx is already install then do not use this script.
Use the following link for manual configuration.
CentOS: 8
https://smarttechfunda.com/automate-the-installation-of-jenkins-on-centos-8-configure-with-nginx/

=======================================================
CentOS: 8
The jenkins-nginx-config script installs the java-11-openjdk, epel repo, Jenkins, and Nginx.
The jenkins-nginx-config script also configured the Jenkins with Nginx.

Ubuntu: 18.04
The jenkins-nginx-config script installs the openjdk-11-jdk, Jenkins and Nginx.
The jenkins-nginx-config script also configured the Jenkins with Nginx.

====How to run the script?====

git clone https://github.com/edutechnolearning/jenkins-nginx.git
cd jenkins-nginx/script
sudo ./jenkins-nginx-config
After successfully installation, use the following URL to configure the Jenkins.
http:// IP
IP: Enter the Jenkins instance IP.
