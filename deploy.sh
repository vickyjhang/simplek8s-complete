docker build -t vickyjhang/multi-client:latest -t vickyjhang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vickyjhang/multi-server:latest -t vickyjhang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vickyjhang/multi-worker:latest -t vickyjhang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vickyjhang/multi-client:latest
docker push vickyjhang/multi-server:latest
docker push vickyjhang/multi-worker:latest

docker push vickyjhang/multi-client:$SHA
docker push vickyjhang/multi-server:$SHA
docker push vickyjhang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vickyjhang/multi-server:$SHA
kubectl set image deployments/client-deployment client=vickyjhang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vickyjhang/multi-worker:$SHA