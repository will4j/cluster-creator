# Kubernetes Cluster Creator

> Construct Cluster by Infrastructure as Code (IaC).

## 前置准备
1. 安装 go-task

    参考：[go-task官方安装指南](https://taskfile.dev/installation/)

2. 安装 ansible

    ```shell
    pip3 install ansible
    ```
    注意根据安装指南将执行路径加入环境变量，使得命令行可以直接识别 `ansible` 命令，如：
    `export Path=$Path:/home/ubuntu/.local/bin`。

3. 安装 kubernetes 库

    ```shell
    pip3 install kubernetes
    ```

4. 安装helm

    参考：[Helm 官方安装指南](https://helm.sh/docs/intro/install/)
    Ubuntu 可使用 snap 安装：
    ```shell
    sudo snap install helm --classic
    ```

5. 安装 kubectl

    参考：[Kubectl 官方安装指南](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
    Ubuntu 可使用 snap 安装：
    ```shell
    sudo snap install kubectl --classic
    ```

6. 安装 vela-cli

   参考：[KubeVela官方文档](https://kubevela.io/docs/installation/kubernetes/#install-vela-cli)

   ```shell
   curl -fsSl https://kubevela.io/script/install.sh | bash
   ```
   
## 集群安装
```shell
$ task --list
task: Available tasks for this project:
* decrypt-vault:                 decrypt vault password
* default:                       list available tasks
* encrypt-vault:                 encrypt vault password
* ping:                          ping test all hosts
* kube:1:                        prepare kubernetes environment
* kube:1.1:                      config /etc/hosts for kubernetes cluster node
* kube:1.2:                      config container environment for kubernetes cluster
* kube:1.3:                      init kubernetes node
* kube:1.4:                      config nvidia container toolkit
* kube:2:                        create kubernetes cluster
* kube:2.1:                      init first kubernetes control plane
* kube:2.2:                      init cni plugin cilium
* kube:2.3:                      join rest node to kubernetes cluster
* kube:2.4:                      change api server node port range
* kube:2.5:                      allow control plane schedule
* kube:2.6:                      label kubernetes cluster node
* kube:2.7:                      init gpushare plugin
* kube:2.8:                      config inner domain to core dns config map
* kube:3:                        config basic cluster component
* kube:3.1:                      nfs pvc as kubernetes cluster storage
* kube:3.2:                      create metrics-server
* kube:3.3:                      create cert-manager
* kube:3.4:                      config cluster cert
* kube:3.5:                      create ingress-nginx
* kube:3.6:                      create kubernetes dashboard
* kube:3.7:                      install harbor helm chart
* kube:3.8:                      install mongodb database
* kube:3.9:                      create kubevela
* ops:admin-local:               download cluster admin config to localhost
* ops:app:gitlab:                install app gitlab
* ops:cert-ca-download:          download ca cert from cluster secret
* ops:distribute-auth-key:       distribute auth ssh key to cluster hosts
* ops:generate-auth-key:         generate remote host auth ssh key pair
* ops:generate-deploy-key:       generate deploy ssh key pair
* ops:reboot-all-hosts:          Reboot all hosts
* ops:set-hostname:              set hostname for cluster node
```

## 参考资料
1. [Ansible Builtin Collection Document](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html)
2. [KubeVela 客户端安装](https://kubevela.io/docs/installation/kubernetes/#install-vela-cli)
3. [Ansible Inventory 指南](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#organizing-host-and-group-variables)
