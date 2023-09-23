# isucon-terraform


2023/9/23現在　private-isuのみ実装

## 注意点
- VPCとサブネットは作成していないのでデフォルトのものを用いている
- キーは自分で用意したものを指定する。
- private-isuに関しては競技者用インスタンスのAMIを用いている。
- 立てるインスタンスの個数を、コマンドラインから指定できる

````
 terraform apply -var="instance_count=2"
````


