# fastapi-uvicorn

## General info
This is a sample fastAPI app running on uvicorn.  

Reference [Build Docker Image with a Single-File FastAPI](https://fastapi.tiangolo.com/deployment/docker/#build-a-docker-image-with-a-single-file-fastapi)

## Prerequisite
- Check that [Datadog Admission Controller](https://docs.datadoghq.com/containers/cluster_agent/admission_controller/?tab=operator) is setup

## Additional Note
- `generate-traffic.sh` is a bash script to generate random traffic load
- sample k8s app deployment included and ready to use (update image if you want to build your own)

## Deploy and run on Kubernetes

```
$ kubectl create -f fastapi-uvicorn-dply.yaml
```

**If you wish to build your own docker image**  

Simply run the build command on the same directory as Dockerfile.
```
$ docker build -t <build_prefix>/<image_name>:<version> .
```

- Check that init container is running

```
$ kubectl describe pod

Look for event
Created container datadog-lib-python-init
Started container datadog-lib-python-init
```

- Check datadog agent that traces are received

```
$ kubectl exec -it <datadog-agent-pod> agent status
```

Look for the APM agent status
```
APM Agent
=========
  Status: Running
  Pid: 1.551948e+06
  Uptime: 179943 seconds
  Mem alloc: 12,213,048 bytes
  Hostname: [Redacted]
  Receiver: 0.0.0.0:8126
  Endpoints:
    https://trace.agent.datadoghq.com

    Receiver (previous minute)
    ==========================
      From python 3.9.18 (CPython), client 1.18.4
        Traces received: 35 (22,610 bytes)
        Spans received: 70


      Priority sampling rate for 'service:fastapi-uvicorn,env:dev': 100.0%
```

- To clean up, delete the deployment

```
$ kubectl delete -f fastapi-uvicorn-dply.yaml
```

And, that is all. Enjoy!
