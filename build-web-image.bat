set /p HOST="HOST: "
set /p HREF="Base-HREF: "

flutter build web --base-href=%HREF% --release ^
--dart-define API_URL="%HOST%/w/api" ^
--dart-define ASSISTANT_URL="%HOST%/w/assistant" && ^
docker build -t marcel1504/weatherapp-ui:3.1.0 .