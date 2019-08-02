#!/usr/bin/env bash

sudo yum update -y

sudo yum install git -y

sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

sudo amazon-linux-extras install docker-compose -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


mkdir ~/programs/
tar -zxvf ~/jdk-8u221-linux-x64.tar.gz ~/programs/
sudo ln -s /programs/jdk1.8.0_221/bin/java /usr/bin/java

sudo mkdir /programs
sudo cp -r /home/ec2-user/programs/jdk1.8.0_221 /programs/
sudo echo "export JAVA_HOME=\"/programs/jdk1.8.0_221\"">>/etc/profile
sudo echo "export PATH=\$JAVA_HOME/bin:\$PATH">>/etc/profile


# sudo vim /etc/profile
# export JAVA_HOME="/programs/jdk1.8.0_221"
# export PATH=$JAVA_HOME/bin:$PATH

#mkdir ~/programs/jenkins
#docker pull jenkins/jenkins
#docker run -d -p 8000:8080 -v ~/programs/jenkins:/var/jenkins_home:z -t jenkins/jenkins


sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo usermod -a -G jenkins ec2-user
#sudo usermod -a -G ec2-user jenkins
sudo usermod -a -G docker jenkins
#sudo vim /etc/sysconfig/jenkins
# JENKINS_USER="ec2-user"
# JENKINS_PORT="8888"
sudo service jenkins start
sudo service jenkins status
