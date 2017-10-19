docker rmi -f jenkins-ssdt-master
docker image build --tag jenkins-ssdt-master --file Dockerfile .