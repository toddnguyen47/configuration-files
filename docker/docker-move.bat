@REM REF: https://stackoverflow.com/a/66314636/6323360

wsl --shutdown
wsl --export docker-desktop-data docker-desktop-data.tar
wsl --unregister docker-desktop-data
wsl --import docker-desktop-data Z:\opt\local\docker docker-desktop-data.tar --version 2
del docker-desktop-data.tar
