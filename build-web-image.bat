set /p URL="API-URL: "
set /p HREF="Base-HREF: "

flutter build web --base-href=%HREF% --release --dart-define=API_URL="%URL%" && ^
docker build -t marcel1504/weatherapp-ui:latest .