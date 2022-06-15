# registry

Based on [Jess Frazelle's Private Docker Repo](https://blog.jessfraz.com/post/personal-infrastructure/#private-docker-registry) setup.

Single stack which runs a private docker registry, including:
- [registry](https://docs.docker.com/registry/deploying/) private registry
- [docker_auth](https://github.com/cesanta/docker_auth) for advanced authentication configuration
- [clair](https://github.com/quay/clair) for vulnerability scanning
- [reg](https://github.com/genuinetools/reg) server (registry UI)
- [nginx](https://docs.linuxserver.io/images/docker-nginx) to proxy all services via a single port (avoiding port pollution on host)

### Usage
1. Edit [.env](.env) file with domain config
2. Edit [docker_auth/auth_config.yml](./docker_auth/auth_config.yml) users and ACL (Update server IP for reg UI calls). [Reference](https://github.com/cesanta/docker_auth/blob/main/examples/reference.yml)
2. Run `make` to generate self signed ssl certs for services
    - Optional: Use your own existing cert and key (ssl/cert.pem, ssl/key.pem)
4. `docker compose up -d`
5. (Optional) Use something like [NginxProxyManager](https://hub.docker.com/r/jlesage/nginx-proxy-manager) or certbot to terminate public SSL and proxy to stack
    - r.example.com -> SERVER_IP:$PROXY_PORT

You can know access your registry via your configured domain and authentication credentials.