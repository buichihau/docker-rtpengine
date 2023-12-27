# Configuration

* vim docker-compose.yml
change IP 
```
MY_IP: IP_Public
```

# Build
```
docker build -t rtpengine:1.0 -f Dockerfile .
```

# Deploy
```
docker-compose up -d
```

# View logs
```
docker logs c-rtpengine -f -n100
```
