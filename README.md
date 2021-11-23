# Dockerized CLI DevOps Environment, by [FEROX](https://ferox.yt)

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/frxyt/devops.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/frxyt/devops.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/frxyt/devops.svg)
![GitHub issues](https://img.shields.io/github/issues/frxyt/docker-devops.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/frxyt/docker-devops.svg)

> This docker image packages with SSH key managment: Ansible, Terraform.

## Docker Hub Image

**`frxyt/devops`**

## Usage

### Single-line

`docker run --rm -it -v ~/.ssh/id_rsa:/home/devops/.ssh/id_rsa:ro -v ~/.ssh/id_rsa.pub:/home/devops/.ssh/id_rsa.pub:ro -v $(pwd):/work frxyt/devops`

### `docker-compose.yml`

```yml
version: '2.4'
services:
  devops:
    image: frxyt/devops
    environment:
      - LOAD_SSH_PRIVATE_KEY_1=/home/devops/.ssh/id_rsa
      - TZ=Europe/Paris
    volumes:
      - ${LINK_SSH_PRIVATE_KEY-~/.ssh/-id_rsa}:/home/devops/.ssh/id_rsa:ro
      - ${LINK_SSH_PRIVATE_KEY-~/.ssh/-id_rsa}${LINK_SSH_PUBLIC_KEY_EXT-.pub}:/home/devops/.ssh/id_rsa.pub:ro
      - ${LINK_SSH_KNOWN_HOSTS-~/.ssh/known_hosts}:/home/devops/.ssh/known_hosts:rw
      - ${LINK_WORKING_DIR-./}:/work:rw
```

Then: `docker-compose run devops`, or: `LINK_SSH_PRIVATE_KEY=~/.ssh/<your_key_name> docker-compose run devops`.

## License

This project and images are published under the [MIT License](LICENSE).

```
MIT License

Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
