docker build -t lechindianer/multi-client:latest -t lechindianer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lechindianer/multi-server:latest -t lechindianer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lechindianer/multi-worker:latest -t lechindianer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lechindianer/multi-client:latest
docker push lechindianer/multi-server:latest
docker push lechindianer/multi-worker:latest

docker push lechindianer/multi-client:$SHA
docker push lechindianer/multi-server:$SHA
docker push lechindianer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lechindianer/multi-client:$SHA
kubectl set image deployments/server-deployment server=lechindianer/multi-server:$SHA
kubectl set image deployments/server-deployment server=lechindianer/multi-worker:$SHA
