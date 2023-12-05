# Kubernetes Cluster Creator

> Construct Cluster by Infrastructure as Code (IaC).
## 前置准备
1. 安装go-task

    参考：[go-task官方安装指南](https://taskfile.dev/installation/)

2. 安装ansible

    ```shell
    pip3 install ansible
    ```
    注意根据安装指南将执行路径加入环境变量，使得命令行可以直接识别`ansible`命令，如：
    `export Path=$Path:/home/ubuntu/.local/bin`。

3. 安装kubernetes库

    ```shell
    pip3 install kubernetes
    ```

4. 安装helm

    参考：[Helm官方安装指南](https://helm.sh/docs/intro/install/)
    Ubuntu可使用snap安装：
    ```shell
    sudo snap install helm --classic
    ```

5. 安装 vela-cli

   参考：[KubeVela官方文档](https://kubevela.io/docs/installation/kubernetes/#install-vela-cli)

   ```shell
   curl -fsSl https://kubevela.io/script/install.sh | bash
   ```

## 参考资料
1. [Ansible Builtin Collection Document](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html)
2. [KubeVela 客户端安装](https://kubevela.io/docs/installation/kubernetes/#install-vela-cli)
