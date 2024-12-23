```
sudo docker buildx create --use
sudo docker buildx inspect --bootstrap
sudo docker buildx build --platform linux/arm64 -t jellyfin:armv8 -f Dockerfile .
sudo docker buildx build --platform linux/arm64 -t fviolence/jellyfin:10.10.3 -f Dockerfile --push .
```
