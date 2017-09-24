#sudo apt install curl
#sudo curl -sSL https://get.docker.com/ | sh

docker run -d --name="home-assistant" -v /home/elias/workspace/infrastructure/bite/dockers/hass/:/config -v /etc/localtime:/etc/localtime:ro --net=host homeassistant/home-assistant
