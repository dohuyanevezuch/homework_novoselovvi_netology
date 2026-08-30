# Итоговый проект курса `DevOps-инженер с нуля` онлайн школы `Нетология`
**Студент:** Новоселов Виктор Иванович
**Группа:** FOPSJ-45

## Оглавление

- [Описание архитектуры](#описание-архитектуры)
- [Репозитории](#репозитории)
- [Зависимости](#зависимости)
- [Воспроизведение](#воспроизведение)

## Описание архитектуры

### Блок схема структуры проекта

> [!WARNING]
> ИЗМЕНИТЬ БЛОК-СХЕМУ С УЧЕТОМ СМЕНЫ GITLAB НА GITHUB

![](https://raw.githubusercontent.com/dohuyanevezuch/Test_website/refs/heads/main/netology/diplom/block-scheme.png)

## Репозитории

- [Инфраструктура](https://github.com/dohuyanevezuch/netology-diplom-inf)
- [Приложение](https://github.com/dohuyanevezuch/netology-diplom-app)

## Зависимости

**Для успешного запуска проекта требуется:**
- Установленный `Yandex CLI`
- Уже выполненая аутентификация в Yandex CLI от имени сервисного аккаунта, который имеет роли:
  - `iam.serviceAccounts.admin`
  - `iam.serviceAccounts.accessKeyAdmin`
  - `compute.editor`
  - `vpc.admin`
  - `vpc.publicAdmin`
- Установленный `Terraform 1.12.0` и выше
- Настроенный `.terraformrc` для работы провайдера yandex cloud
- Установленный `Ansible`
- ...


## Воспроизведение

### 1. terraform/bootstrap

- Создать `terraform.tfvars`

```bash
touch terraform/bootstrap/terraform.tfvars
```

- Сменить bucket_name

```bash
NEW_BUCKET="Уникальное имя" && \
sed -i -E "s|^([[:space:]]*bucket[[:space:]]*=[[:space:]]*)\"[^\"]+\"|\1\"$NEW_BUCKET\"|" terraform/infrastructure/backend.hcl && \
grep -q '^state_bucket_name' terraform/bootstrap/terraform.tfvars \
  && sed -i -E "s|^([[:space:]]*state_bucket_name[[:space:]]*=[[:space:]]*)\"[^\"]+\"|\1\"$NEW_BUCKET\"|" terraform/bootstrap/terraform.tfvars \
  || echo "state_bucket_name = \"$NEW_BUCKET\"" >> terraform/bootstrap/terraform.tfvars
```

Выполнить экспорт переменных

```bash
export TF_VAR_token=$(yc iam create-token) 
export TF_VAR_cloud_id=$(yc config get cloud-id)
export TF_VAR_folder_id=$(yc config get folder-id)
```
Инициализировать и запустить проект

```bash
cd terraform/bootstrap

terraform init
terraform plan
terraform apply
```

После выполнения bootstrap импортировать переменные S3:

```bash
export AWS_ACCESS_KEY_ID="$(terraform output -raw state_access_key)"
export AWS_SECRET_ACCESS_KEY="$(terraform output -raw state_secret_key)"
```

### 2. terraform/infrastructure

ереходишь в infrastructure:

```bash
cd ../infrastructure
```
и выполняешь

```bash
terraform init -backend-config=backend.hcl
```

После выполнения:

```bash
yc iam key create \
  --service-account-id "$(terraform output -raw github_actions_service_account_id)" \
  --output github-actions-key.json
```
Содержимое помещаем в 

```bash
App repo -> Settings -> Secret and validate -> Actions -> new repository secret -> YC_SA_KEY_JSON
```

и

```bash
terraform output -raw container_registry_id
```
Содержимое помещаем в 

```bash
App repo -> Settings -> Secret and validate -> Actions -> new repository secret -> YC_REGISTRY_ID
```