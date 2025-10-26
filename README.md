# ⚠️ Archived project

> **This repository has been archived and is no longer maintained.**
>
> This was a university project from Semester 5 (Distributed Systems course) and is being preserved for reference purposes only. Dependencies are outdated and there is no intention to resolve security vulnerabilities or update packages.
>

---

# DevOps Project

## Content

- [Application](#application)
- [Azure](#azure)
- [Docker](#docker)
- [Dockerc-compose](#docker-compose)
- [Vagrant](#vagrant)
- [Ansible](#ansible)
- [Kubernetes](#kubernetes)

### Application

#### Backend

It's the same as [here](https://github.com/jgenc/hua-distributed-project-backend), so you can assume that when you navigate
to `/docs` there is an Adminstrator with `admin:admin` username:password!

#### Frontend

It's the same as [here](https://github.com/jgenc/hua-distributed-project-frontend), so you can assume that when you navigate
to `/#/login` you can login using `admin:admin` as username:password.

### Azure

#### Connecting various networks

For internal Vnets to talk to eachother, we can do either of the following:

1. When creating a VM, choose the Vnet of choice (only one should exist)
2. If you did not choose the same Vnet, you should create a "Peering" which connects Vnets! This means, VMs can communicate by using their internal IP!

### Docker

#### Pull/use packages already created

1. `ghcr.io/jgenc/devops-backend`, a FastAPI backend. You can access `/docs` to see the OpenAPI and to see what methods exists, or you can refer to the repository's `openapi.json` file [here](https://github.com/jgenc/hua-distributed-project-backend/blob/09ab07d81734cf7084ffc298d77519094f40b096/openapi.json). Try using `/api/auth/login` with Postman or any other similar software
2. `ghcr.io/jgenc/devops-fronend-prod`, an NGINX image that serves a SolidJS SPA. It is implemented using a hash mode router (meaning all routes must start with '#', i.e. `/#/login` is valid but `/login` is not!). Quite performant and good looking.

### Docker-compose

The `docker-compose.yml` file will deploy the **whole** stack to a target, either if that's a VM, local installation, kubernetes, you name it. It pulls the latest docker images and it is tested both on Vagrant VMs and on my local machine.

### Vagrant

#### Cursor blinking bug

Sometimes, when running `vagrant up backend` and afterwards I another command, let's say
`vagrant up db`, this just does nothing! Well, I finally figured out why. The fix is the following

Kill all processes that are associated with:

- vagrant
- virt

I know that this sounds weird, but it fixed my weird errors...

### Ansible

The backend component has a docker and a VM implementation, whilst the frontend component has docker-jenkins, docker, nginx-vm, and vite implementations. The `vite` one is used for local development, it's quite handy.

##### Example Executions

`ansible-playbook -i hosts.yml -l azure-deploy-1 playbooks/frontend-docker.yml`

`ansible-playbook -i hosts.yml -l frontend playbooks/frontend-nginx-vm.yml`

`ansible-playbook -i hosts.yml -l azure-deploy-1 playbooks/backend-vm.yml`

`ansible-playbook -i hosts.yml -l backend playbooks/backend-docker.yml`

### Kubernetes

All files are under the `k8s` folder. There you can find files for the backend component, the frontend component, the database and the certbot. Backend and Frontend both contain an ingress file, which is useful to route all backend api calls to `HOST_URL/api` and all frontend to `HOST_URL/` (-> `/HOST_URL/#/` because of the hash mode router!)

If you want to install this to your cluster you have to `kubectl apply -f <file-name>` all files that are relevant to you

#### Example - Frontend

- Modify `frontend.env.yml`
- Modify `frontend-ingress.yml`
- Apply all the files under `k8s/frontend` to your cluster

And you should be ready to go! Same applies to the `k8s/backend` and `k8s/db` folders
