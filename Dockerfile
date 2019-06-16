# Luke williams - Windows Server Core 2019 with Deadline Slave and Houdini installed from Chocolatey repo.

# base image.
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Metadata indicating an image maintainer.
LABEL maintainer="l.williams@derby.ac.uk"

# Install Chocolatey
RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Deadline slave from internal repository
RUN powershell -Command choco install deadline-dockerversion -y --source=https://chocolatey-tst.derby.ac.uk/chocolatey

#Install Houdini from internal repository
RUN powershell -Command choco install houdini -y --source=https://chocolatey-tst.derby.ac.uk/chocolatey

#Add to PATH var script
RUN powershell -Command '[Environment]::SetEnvironmentVariable("Path", $env:Path + ";c:\program files\thinkbox\deadline10\deadlinelauncher.exe")'

#Deadline ports
EXPOSE 17001/tcp
EXPOSE 17000/tcp
EXPOSE 49173/tcp

#Set working directory to Deadline program dir
WORKDIR "C:\Program Files\Thinkbox\Deadline10\bin"

#Map Deadline repository share
ADD scripts/map_repository.ps1 /map_repository.ps1

# Sets a command or process that will run each time a container is run from the new image.
CMD "powershell -Command c:\map_repository.ps1 && Deadlinelauncher.exe"