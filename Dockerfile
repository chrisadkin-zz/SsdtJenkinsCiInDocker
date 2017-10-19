# escape=`
FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN mkdir \jenkins  
RUN powershell -Command `
    wget -Uri 'https://updates.jenkins-ci.org/download/war/2.0/jenkins.war' -UseBasicParsing -OutFile '/jenkins/jenkins.war'

RUN powershell -Command ` 
    Set-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force

RUN choco install netfx-4.5.2-devpack -y --force
    
RUN powershell -Command `  
    wget 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185' -Outfile 'C:\jreinstaller.exe' ; `
    Start-Process -filepath C:\jreinstaller.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\Java\jre1.8.0_91" ; `
    del C:\jreinstaller.exe

RUN powershell -Command `
    Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force
    
RUN C:\Chocolatey\bin\nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61026

RUN choco install microsoft-build-tools -version 14.0.25420.1 -y --force
    
RUN choco install git -y

ENV HOME /jenkins  
ENV JENKINS_VERSION 2.0  
ENV JAVA_HOME c:\\Java\\jre1.8.0_91  

EXPOSE 8080  
EXPOSE 50000

RUN mkdir C:\Projects

CMD c:\\Java\\jre1.8.0_91\\bin\\java -jar C:\\jenkins\\jenkins.war  