Є курси криптовалют до долару CША з наступного фіду https://api.coinmarketcap.com/v1/ticker/


Написати веб додаток на Elixir/Phoenix, який буде колекціонувати дані з цього фіду в базу Postgresql без дублювання, а на вебі видавати дані по точкам за кожну секунду часу через Google Chart. Графік має бути динамічний зі зглажуваннями. По замовчуванню показуються дані за останню годину, але можна змінювати інтервал. Додаток покрити тестами, інтегрувати в CircleCI і написати скрипти для деплойменту з Minikube в k8s локально.

---
minikube start
kubectl -n rates create -f ./k8s/rates-deployment.yaml
kubectl config set-context --current --namespace=rates
kubectl expose deployment rates-deployment --type=LoadBalancer --port=4000

kubectl -n rates get pods
