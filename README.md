# Spin up fast backends for prototypes (stripped)

Blueprint and Orchid as base packages. Blueprint points to my fork for enabled Orchid support in Blueprint generated models. Nano is added to do nasty stuff to container files. Used Kubernetes as deploy example, this is not the way _cluck cluck cluck_ make a helm chart or something nice.

## Build image

```bash
docker build -t orchid .
docker build -t [image name] [path to dockerfile]
```

## Deploy to kubernetes (the not production worthy way)

database config and others need to be added by .env or at deployment command.

```bash
kubectl run laravel --image=orchid --port=80 --image-pull-policy=IfNotPresent --env=APP_KEY=base64:cUPmwHx4LXa4Z25HhzFiWCf7TlQmSqnt98pnuiHmzgY=
kubectl run [some name] --image=[image name]
```

## Run inside container to migrate & seed

```bash
cd /app && yes | php artisan db:wipe && yes | php artisan migrate && yes | php artisan db:seed && yes | php artisan orchid:admin admin admin@admin.local orchid
```

## Delete from kubernetes

```bash
kubectl delete deploy laravel
kubectl delete deploy [some name]
```
