# isucon-terraform


2023/9/23現在　private-isuのみ実装

## 手順
-terraformを自分のAWSアカウントと結びつけて、使えるようにしておく
-キーペアの作成

`$ ssh-keygen -t rsa -f isucon -N ''`
上記のコマンド等でISUCON用キーペアを作成しておく
サンプルでは　~/.ssh下においている。

- コマンド実行

````
 terraform apply -var="instance_count=2" -var="pub_key_location=~/.ssh/isucon.pub"
````

引数
instance_count 立てるインスタンスの数を指定

pub_key_location 公開鍵の場所を指定。一々指定するのがめんどくさい場合は、




## 注意点
- VPCとサブネットは作成していないのでデフォルトのものを用いている
- キーは自分で用意したものを指定する。
- private-isuに関しては競技者用インスタンスのAMIを用いている。
- 立てるインスタンスの個数を、コマンドラインから指定できる


