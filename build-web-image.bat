set /p HOST="HOST: "

flutter build web --base-href=/w/app/ --release ^
--dart-define API_URL="%HOST%/w/api" ^
--dart-define ASSISTANT_URL="%HOST%/w/assistant" && ^
docker build -t marcel1504/weatherapp-ui:3.1.1 .