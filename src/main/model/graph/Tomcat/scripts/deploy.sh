#!/bin/bash

# Install required packages
apt-get update
apt-get -y install wget
apt-get -y install unzip
apt-get -y install default-jre-headless

# Download and unzip Tomcat
cd ~
wget http://www.us.apache.org/dist/tomcat/tomcat-7/v7.0.64/bin/apache-tomcat-7.0.64.zip
unzip apache-tomcat-7.0.64.zip
mv apache-tomcat-7.0.64 tomcat
chmod 775 tomcat/bin/*.sh

# Update the configuration files
cp $ROBOCONF_FILES_DIR/server.xml ~/tomcat/conf/server.xml
sed -i "s/_ajpPort_/$ajpPort/g" ~/tomcat/conf/server.xml
sed -i "s/_serverPort_/$serverPort/g" ~/tomcat/conf/server.xml
sed -i "s/_httpPort_/$httpPort/g" ~/tomcat/conf/server.xml

# Update the welcome page
cat << EOF > ~/tomcat/webapps/ROOT/index.html
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>Apache Tomcat</title>
</head>

<body>
<h1>It works !</h1>
<p>From Tomcat at: $ip</p>

</body>
</html>
EOF
