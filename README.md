# Simple Attendance by Seat Id

Java 11 servlet lab built with Ant, packaged as a WAR, and deployed with Tomcat 9.

## Local build

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home
export PATH=/opt/homebrew/opt/openjdk@11/bin:$PATH
"/Applications/Apache NetBeans.app/Contents/Resources/netbeans/extide/ant/bin/ant" clean package
```

The command creates `attendance.war` in the project root.

## Render deployment

The Docker image deploys the application as `ROOT.war`, so the attendance form is available directly at the Render service root URL.

Required files in the repository root:

- `attendance.war`
- `Dockerfile`
- `entrypoint.sh`

The application stores attendance in memory. Deploys, restarts, and container replacement erase all records.
