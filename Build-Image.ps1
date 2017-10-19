docker rmi -f chrisadkin/jenkins-ssdt-master:v1
docker image build --tag chrisadkin/jenkins-ssdt-master:v1 --file Dockerfile .
