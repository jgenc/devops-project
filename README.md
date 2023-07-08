# DevOps Project

## Content

### Application

#### Backend

It's the same as [here](https://github.com/jgenc/hua-distributed-project-backend), so you can assume that when you navigate
to `/docs` there is an Adminstrator with `admin:admin` username:password!

#### Frontend

### Azure

#### Connecting various networks

For internal Vnets to talk to eachother, we can do either of the following:

1. When creating a VM, choose the Vnet of choice (only one should exist)
2. If you did not choose the same Vnet, you should create a "Peering" which connects Vnets! This means, VMs can communicate by using their internal IP!

### Docker

#### `devops-backend` package

Test

### Vagrant

#### Cursor blinking bug

Sometimes, when running `vagrant up backend` and afterwards I another command, let's say
`vagrant up db`, this just does nothing! Well, I finally figured out why. The fix is the following

Kill all processes that are associated with:

- vagrant
- virt

I know that this sounds weird, but it fixed my weird errors...

### Ansible

#### `backend.yml` Playbook

Sets up the database and backend. Assumes **two** VMs, which, of course, could
also be just one. It all depends on what values the host has. For example:

```yaml
azure:
  hosts:
    backend:
      ansible_host: devops-azure-vm-1
    db:
      ansible_host: devops-azure-vm-2
      # or
      ansible_host: devops-azure-vm-1
```

This is possible because in the playbook there exists a play that retrieves the
database's IP, which is then feeded to the backend to accordingly modify the
`.env` file.

##### Example Executions

`ansible-playbook playbooks/backend.yml -i hosts/vagrant.yml`

`ansible-playbook playbooks/backend.yml -i hosts/azure.yml`
