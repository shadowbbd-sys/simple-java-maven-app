@echo off
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data
echo volume).

echo [DEBUG] Command: mvn jar:jar install:install help:evaluate -Dexpression=project.name
mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo The following command extracts the value of the ^<name/^> element
echo within ^<project/^> of your Java/Maven project's "pom.xml" file.

echo [DEBUG] Command: mvn -q -DforceStdout help:evaluate -Dexpression=project.name
for /f "delims=" %%I in ('mvn -q -DforceStdout help:evaluate -Dexpression^=project.name') do set NAME=%%I

echo The following command behaves similarly to the previous one but
echo extracts the value of the ^<version/^> element within ^<project/^> instead.

echo [DEBUG] Command: mvn -q -DforceStdout help:evaluate -Dexpression=project.version
for /f "delims=" %%I in ('mvn -q -DforceStdout help:evaluate -Dexpression^=project.version') do set VERSION=%%I

echo The following command runs and outputs the execution of your Java
echo application (which Jenkins built using Maven) to the Jenkins UI.

echo [DEBUG] Command: java -jar target\%NAME%-%VERSION%.jar
java -jar target\%NAME%-%VERSION%.jar
