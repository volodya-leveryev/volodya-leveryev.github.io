# AWS Cloudformation

## Теория

Infrastructure as a Code — подход к развертывания облачной инфраструктуры при
котором требуемые ресурсы описываются с помощью кода (например в виде
скриптов).

AWS CloudFormation поддерживает описание инфраструктуры в форматах JSON и YAML.

Аналоги:
- [AWS CloudFormation](https://aws.amazon.com/cloudformation/)
- [Azure Resource Manager](https://azure.microsoft.com/en-us/get-started/azure-portal/resource-manager/)
- [Google Cloud Deployment Manager](https://cloud.google.com/resource-manager)
- [Terraform](https://www.terraform.io/) — не зависит от вендора
- [Ansible](https://www.ansible.com) / [Chef](https://www.chef.io) /
  [Puppet](https://www.puppet.com) / [Salt](https://saltproject.io) — .

Подходы к IaaC:
- декларативный — в коде описывается результат которого нужно добиться (AWS
  CloudFormation).
- императивный — в коде описываются шаги для развертывания необходимой
  инфраструктуры.
- гибридный — сочетает декларативный и императивный подходы.

Преимущества:
- скорость повторного развертывания

Недостатки:
- медленное прототипирование

В терминах AWS CloudFormation описание инфраструктуры фиксируется в **шаблонах
(Template)**.

**Стек (Stack)** - набор инфраструктуры который создан на базе одного шаблона.

В шаблонах можно задавать использование **параметров (parameters)**. Их
значения задаются в момент развертывания шаблона.

При развертывании пользователю могут быть выданы результирующие значения —
**Outputs**.

Для создания связей ресурсов друг с другом в шаблонах используются **ссылки
(reference)**.

[Документация](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

[Справочник ресурсов и
свойств](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)

## Практика

Создать шаблон:
- Начальный пример по созданию бакета S3
- Создание инстанса EC2 (ссылки и зависимости)
- Установка ПО и файлов приложения

```
Parameters:
  NewBucketName:
    Description: Set a name for new bucket
    Type: String

Resources:
  HelloBucket:
    Type: 'AWS::S3::Bucket'
    Properties:
      BucketName: !Ref NewBucketName

Outputs:
  CreatedBucketName:
    Value: !Ref HelloBucket
```
