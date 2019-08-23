Є курси криптовалют до долару CША з наступного фіду https://api.coinmarketcap.com/v1/ticker/


Написати веб додаток на Elixir/Phoenix, який буде колекціонувати дані з цього фіду в базу Postgresql без дублювання, а на вебі видавати дані по точкам за кожну секунду часу через Google Chart. Графік має бути динамічний зі зглажуваннями. По замовчуванню показуються дані за останню годину, але можна змінювати інтервал. Додаток покрити тестами, інтегрувати в CircleCI і написати скрипти для деплойменту з Minikube в k8s локально.

---
js: https://gitlab.com/yuriy.zdyrko/rates/blob/master/apps/rates_web/assets/js/App.vue

ex: https://gitlab.com/yuriy.zdyrko/rates/tree/master/apps/rates/lib/rates

tests: https://gitlab.com/yuriy.zdyrko/rates/tree/master/apps/rates/test/rates

CI/CD: https://gitlab.com/yuriy.zdyrko/rates/blob/master/.gitlab-ci.yml

k8s: https://gitlab.com/yuriy.zdyrko/rates/blob/master/k8s/rates-deployment.yaml

---
Download and run release with minikube:

minikube start

kubectl create -f ./k8s/rates-deployment.yaml

kubectl expose deployment rates-deployment --type=NodePort --port=80

minikube service rates-deployment

---
Build and run release with docker-compose:

docker-compose up
