## My first FullStack/DevOps pet project!
---

#### Business logic: 
- with 1 second intervals, grab crypto-currencies' to usd rates from public endpoint:
 https://api.coinmarketcap.com/v1/ticker/
- store rates in database
- display rates as a chart on UI, updating chart every second

---
#### Implementation details:
- UI: Vue.js, Google Chart
- Backend: Elixir/Phoenix
- Database: PostgreSQL
- CI: GitLab
- Container management: docker-compose and k8s
---

#### Important files:
- chart: https://github.com/banzay/btc-rates-visualisation/blob/master/apps/rates_web/assets/js/App.vue
- business logic: https://github.com/banzay/btc-rates-visualisation/blob/master/apps/rates/lib/rates
- tests: https://github.com/banzay/btc-rates-visualisation/blob/master/apps/rates/test/rates
- gitlab: https://github.com/banzay/btc-rates-visualisation/blob/master/.gitlab-ci.yml
- k8s: https://github.com/banzay/btc-rates-visualisation/blob/master/k8s/rates-deployment.yaml
---

#### Download and run release with minikube:

```console
minikube start
kubectl create -f ./k8s/rates-deployment.yaml
kubectl expose deployment rates-deployment --type=NodePort --port=80
minikube service rates-deployment
```

---
#### Build and run release with docker-compose:

```console
docker-compose up
```