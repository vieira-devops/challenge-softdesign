# SoftDesign - Challenge

Desafio proposto pelo time da SoftDesign.
O desafio foi todo executado e elaborado com Minikube e posteriormente migrado para o EKS da AWS, para fazer melhor integração com CI/CD do GitHub Actions.

### Requesitos
* **AWS Account + AWS (CLI)**
* **S3 Bucket** (*Opcional - Caso não queria criar um bucket para salvar seu TF State, remova a configuração de backend no arquivo ```providers.tf```*)
* **Terraform**
* **Kubectl**

# ⚙️ Construindo Ambiente

Faça o clone deste repositório com:
``` bash
git clone git@github.com:vieira-devops/challenge-softdesign.git
```

Após o clone, acesse a pasta do projeto (```challenge-softdesign```):
```bash
cd challenge-softdesign
```

E agora vamos iniciar o projeto via terraform, acesse a pasta ```terraform``` <br>
E inicie o Terraform:
```bash
cd terraform && terraform init
```

Perfeito, agora vamos validar a estrutura do terraform com o seguinte comando:
```bash
terraform validate
```
***Observação:*** *caso apresente alguma mensagem de erro, valide as alterações caso tenha feita alguma.*

Vamos ver nosso plano de execução? Execute o seguinte comando agora:
```bash
terraform plan -out=<filename>
```

Legal, provavelmente vai ter listado que vai criar **60** itens. Vamos seguir!
```bash
terraform apply "<filename>" --auto-approve
```

### 🗒️ Outputs

Após um bom tempo (**15min +/-**), seu ambiente **EKS** foi criado e você deve ter recebido os seguintes outputs em tela:
```bash
Apply complete! Resources: 60 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = "https://******.gr7.us-east-1.eks.amazonaws.com"
cluster_name = "softdesin-eks-cluster"
cluster_security_group_id = "sg-******"
region = "us-east-1"
```

## 🐳 Deploy K8s
Agora que nosso ambiente está pronto que tal subirmos nossa estrutura?

Atualize o ```kubeconfig``` com o seguinte comando abaixo:
```bash
aws eks update-kubeconfig --region us-east-1 --name softdesign-eks-cluster
```
##
### 📢 Atenção!
Se estiver executando localmente, considere ajustar as entradas no arquivo ```db-secrets.yml``` pois esta configurado para executar de acordo com as váriaveis do **GitHub Actions**.

Para usar os Workflows do projeto você vai precisar ter criado as seguintes váriaveis:

* 🔒 **AWS_ACCESS_KEY_ID**
* 🔒 **AWS_SECRET_ACCESS_KEY**
* 🔒 **AWS_DEFAULT_REGION**
* 🔒 **AWS_REGION**
* 🔒 **MONGO_USERNAME**
* 🔒 **MONGO_PASSWORD**

##

Acesse a pasta ```./manifest/``` e vamos ao Deploy!
```bash
kubectl apply -f .
```

### 🥳 Parabéns você executou tudo corretamente!

##

### 🧪 Vamos testar o ambiente? Vamos!
Lembra que recebemos os **Outputs**? Vamos usar ele agora, busque a saída ```cluster_endpoint```.

Acesse a URL via navegador com a porta **3000**:
```bash
http://******.gr7.us-east-1.eks.amazonaws.com:3000
```

Perfeito, mas a página parece meio vazia né? Vamos inserir alguns dados ali.

Execute o seguinte comando:
```bash
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"campoData":"campoValor"}' \
  http://******.gr7.us-east-1.eks.amazonaws.com:3000
```

Agora volte na aba do navegador e de um refresh (F5), **AGORA SIM!!**

Você também pode consultar via console com o seguinte comando:
```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://******.gr7.us-east-1.eks.amazonaws.com:3000
```

Legal né? um desafio interessante e que existem várias possibilidades para explorarmos e melhorar ainda mais o projeto.