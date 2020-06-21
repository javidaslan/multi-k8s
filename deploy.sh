# build images
docker build -t javidaslan/multi-client:latest -t javidaslan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t javidaslan/multi-server:latest -t javidaslan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t javidaslan/multi-worker:latest -t javidaslan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push latest images to docker hub
docker push javidaslan/multi-client:latest
docker push javidaslan/multi-server:latest
docker push javidaslan/multi-worker:latest

# push SHA images to docker hub
docker push javidaslan/multi-client:$SHA
docker push javidaslan/multi-server:$SHA
docker push javidaslan/multi-worker:$SHA

# apply config files
kubectl apply -f k8s

# set image to the latest version
kubectl set image deployments/client-deployment client=javidaslan/multi-client:$SHA
kubectl set image deployments/server-deployment server=javidaslan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=javidaslan/multi-worker:$SHA
