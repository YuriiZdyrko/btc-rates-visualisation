Є курси криптовалют до долару CША з наступного фіду https://api.coinmarketcap.com/v1/ticker/


Написати веб додаток на Elixir/Phoenix, який буде колекціонувати дані з цього фіду в базу Postgresql без дублювання, а на вебі видавати дані по точкам за кожну секунду часу через Google Chart. Графік має бути динамічний зі зглажуваннями. По замовчуванню показуються дані за останню годину, але можна змінювати інтервал. Додаток покрити тестами, інтегрувати в CircleCI і написати скрипти для деплойменту з Minikube в k8s локально.

1. Umbrella mode - just in case app will grow
2. Used Mix.Release to create deployment binary
3. Production database credentials are kept in CircleCI
