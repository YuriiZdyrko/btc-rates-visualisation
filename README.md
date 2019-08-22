Є курси криптовалют до долару CША з наступного фіду https://api.coinmarketcap.com/v1/ticker/


Написати веб додаток на Elixir/Phoenix, який буде колекціонувати дані з цього фіду в базу Postgresql без дублювання, а на вебі видавати дані по точкам за кожну секунду часу через Google Chart. Графік має бути динамічний зі зглажуваннями. По замовчуванню показуються дані за останню годину, але можна змінювати інтервал. Додаток покрити тестами, інтегрувати в CircleCI і написати скрипти для деплойменту з Minikube в k8s локально.

---
minikube start
kubectl create -f ./k8s/rates-deployment.yaml
kubectl expose deployment rates-deployment --type=NodePort --port=4000
minikube service rates-deployment --url

kubectl get pods
kubectl logs -f POD_ID -c rates
