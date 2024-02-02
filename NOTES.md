# After upgrading docker, might have to...
```
docker buildx create --use
```

# Build for local testing
```
docker buildx build --platform linux/arm64 --tag horologger/lndshell:v0.0.0 --load .
```

# Build and push to docker hub
```
docker buildx build --platform linux/arm64,linux/amd64 --tag horologger/lndshell:v0.0.0 --output "type=registry" .
```

#First run on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-e LNCLI_RPCSERVER=ragnar:10009 \
-e LNCLI_TLSCERTPATH="/lnd/tls.cert" \
-e LNCLI_MACAROONPATH="/lnd/data/chain/bitcoin/mainnet/admin.macaroon" \
-v data:/data \
--mount type=bind,source="$(pwd)"/lnd,target=/lnd,readonly \
-p 8080:8080 \
--name lndshell \
-it horologger/lndshell:v0.0.0
```
#Subsequent runs on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-e LNCLI_RPCSERVER=ragnar:10009 \
-e LNCLI_TLSCERTPATH="/lnd/tls.cert" \
-e LNCLI_MACAROONPATH="/lnd/data/chain/bitcoin/mainnet/admin.macaroon" \
-v data:/data \
--mount type=bind,source="$(pwd)"/lnd,target=/lnd,readonly \
-p 8080:8080 \
-it horologger/lndshell:v0.0.0
```

# Inspect
```sh
docker exec -it lndshell /bin/bash
```
# Clean up
```sh
docker stop lndshell
docker rm lndshell
```
