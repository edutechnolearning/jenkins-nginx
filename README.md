# jenkins-nginx
=======================================================

Note: 

The jenkins-nginx-config script works on CentOS 8 and Ubuntu 18.04 only.
If Jenkins and Nignx is already install then do not use this script.
Use the following link for manual configuration.

CentOS: 8

https://smarttechfunda.com/automate-the-installation-of-jenkins-on-centos-8-configure-with-nginx/

The jenkins-nginx-config script installs the java-11-openjdk, epel repo, Jenkins, and Nginx.
The jenkins-nginx-config script also configured the Jenkins with Nginx.

=======================================================

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

# Upgrade Jenkins
=======================================================

The upgrade_jenkins script upgrade jenkins version.
The upgrade_jenkins script display the installed version and the latest available version.
The upgrade_jenkins script prompts the user to enter the latest available version, which displays while upgrading.
According to OS, this script takes the default installation path. If the user installed Jenkins on a different path, it asks the user to prompt the enter the path where Jenkins installed.
This script takes the backup of old jenkins.war file, and fails to upgrade the jenkins due to any reason, it restores the old jenkins.war file with restart the jenkins service.

Note: 
The upgrade_jenkins script supports OS CentOS 7 and Ubuntu 18.04
====How to run the script?====

git clone https://github.com/edutechnolearning/jenkins-nginx.git <br>
cd jenkins-nginx/script <br>
./upgrade-jenkins
