FROM tomcat:8
LABEL app=CICD with ansible
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/myapp2021.war
