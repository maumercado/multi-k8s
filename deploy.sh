docker build -t maumercado/multi-client:latest -t maumercado/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maumercado/multi-server:latest -t maumercado/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maumercado/multi-worker:latest -t maumercado/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push maumercado/multi-client:latest
docker push maumercado/multi-server:latest
docker push maumercado/multi-worker:latest

docker push maumercado/multi-client:$SHA
docker push maumercado/multi-server:$SHA
docker push maumercado/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=maumercado/multi-server:$SHA
kubectl set image deployments/client-deployment client=maumercado/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maumercado/multi-worker:$SHA