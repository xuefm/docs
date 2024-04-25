### 通过SSH密钥进行身份验证

通过SSH密钥进行身份验证通常比使用密码更安全和方便。以下是使用SSH密钥进行身份验证的步骤：

**生成SSH密钥对**：在本地系统上生成SSH密钥对，其中包括一个私钥和一个公钥。你可以使用以下命令生成SSH密钥对：

```bash
ssh-keygen -t rsa 
```

这将在默认的`~/.ssh/`目录下生成一个RSA密钥对。

**复制公钥到远程服务器**：将生成的公钥复制到远程服务器上的`~/.ssh/authorized_keys`文件中。你可以使用以下命令将公钥复制到远程服务器：

```bash
ssh-copy-id username@remote_host
```

替换`username`和`remote_host`为你在远程服务器上的用户名和主机名或IP地址。然后，你需要输入远程服务器的密码。

**验证SSH连接**：完成上述步骤后，你就可以通过SSH连接到远程服务器而无需输入密码。尝试使用以下命令连接到远程服务器：

```bash
ssh username@remote_host
```

如果一切设置正确，你将可以无密码登录到远程服务器。

**上传文件**：现在，你可以使用scp命令将文件上传到远程服务器，而无需输入密码：

```bash
scp /path/to/local/file username@remote_host:/path/to/remote/directory
```

替换相应的路径和用户名。由于已经设置了SSH密钥，你不再需要输入密码。

