docker build -t rnmt000/multi-client:latest -t rnmt000/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rnmt000/multi-server:latest -t rnmt000/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rnmt000/multi-worker:latest -t rnmt000/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rnmt000/multi-client:latest
docker push rnmt000/multi-server:latest
docker push rnmt000/multi-worker:latest
docker push rnmt000/multi-client:$SHA
docker push rnmt000/multi-server:$SHA
docker push rnmt000/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rnmt000/multi-server:$SHA
kubectl set image deployments/client-deployment client=rnmt000/multi-client:$SHA
kubectl set image deployments/worker-deployment client=rnmt000/multi-worker:$SHA
