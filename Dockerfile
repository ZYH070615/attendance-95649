# Run the Java 11 web application on Tomcat 9.
FROM tomcat:9.0-jdk11-corretto

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/ROOT.war \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Deploy as ROOT.war so the assignment URL works directly at /.
COPY attendance.war /usr/local/tomcat/webapps/ROOT.war
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod +x /usr/local/tomcat/bin/entrypoint.sh

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]
