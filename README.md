# jenkins-nginx
=======================================================

# Note: 
The jenkins-nginx-config script works on CentOS 8 only.
If Jenkins and Nignx is ready install then do not use this script.
Use the following link for manual configuration.
https://smarttechfunda.com/automate-the-installation-of-jenkins-on-centos-8-configure-with-nginx/

=======================================================

The jenkins-nginx-config script installs the java-11-openjdk, epel repo, Jenkins, and Nginx.
The jenkins-nginx-config script also configured the Jenkins with Nginx.

====How to run the script?====

git clone https://github.com/edutechnolearning/jenkins-nginx.git
cd jenkins-nginx/script
sudo ./jenkins-nginx-config
After successfully installation, use the following URL to configure the Jenkins.
http:// IP
IP: Enter the Jenkins instance IP.
