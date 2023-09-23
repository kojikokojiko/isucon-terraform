# isucon-terraform


2023/9/23現在　private-isuのみ実装

## 手順
- terraformを自分のAWSアカウントと結びつけて、使えるようにしておく
- キーペアの作成

`$ ssh-keygen -t rsa -f isucon -N ''`
上記のコマンド等でISUCON用キーペアを作成しておく
サンプルでは~/.ssh下においている。

- コマンド実行

````
 terraform apply -var="instance_count=2" -var="pub_key_location=~/.ssh/isucon.pub"
````

引数

instance_count 立てるインスタンスの数を指定


pub_key_location 公開鍵の場所を指定。

一々指定するのがめんどくさい場合は、

```
#公開鍵の場所
variable "pub_key_location" {
  description = "Location of public key"
  default     = "~/.ssh/isucon.pub"
}

```

デフォルト値を好きなように編集しておく。



- publiv-dns(ip)を取得して、SSH設定
好きなようにSSHをする。

### VSCodeのRemote SSHを使用している人におすすめの設定
VSCodeのRemote SSHでは、~/.ssh/configに書かれたUserが権限を持つファイルしか書き換えができないため
~/isuconにあるアプリケーションコードの編集ができない。

これを回避するために、筆者は isucon Userの状態で、authorized_keyなどを設定して、
直でisucon UserにSSHできるように設定するという、圧倒的二度手間をしていた。


しかし、VSCode Remote SSHを使って、直でisucon UsernにSSH方法があったらしい😭


```

Host private-isu-*
  HostName 
  User ubuntu
  IdentityFile ~/.ssh/isucon

Host private-isu-isucon
  RemoteCommand sudo su isucon
```
こんな感じで RemoteCommandを使うと、直でisucon UserでRemote SSHすることができる。

ちなみに、RemoteCommandを使えるようにするにはVSCodeの設定をいじっておく必要がある。

```
{
    "remote.SSH.useLocalServer": true,
    "remote.SSH.enableRemoteCommand": true,

   //　ここは、空にしておくのがベター、Host名がかぶっているものがあるとそちらが優先されてしまう
    "remote.SSH.remotePlatform": {
        // "private-isu-isucon": "linux",
        // "yyyyy": "linux",
        "zzzzz": "linux"
    }
}

```


参考記事
[https://qiita.com/craymaru/items/f126597ed91940226805]





## 注意点
- VPCとサブネットは作成していないのでデフォルトのものを用いている
- private-isuに関しては競技者用インスタンスのAMIを用いている。



## 拡張予定
他のISUCON過去問にも対応させる。コマンドラインからどの過去問の環境を作るか指定できるようにする。
