FROM tomcat:8
LABEL app=my-app
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/myapp2021.war
