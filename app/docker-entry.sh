uvicorn --host 0.0.0.0 --port 8080 main:app &
sleep 5
./generate-traffic.sh
