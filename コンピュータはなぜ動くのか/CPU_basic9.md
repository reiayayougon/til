## ９章ネットワークコマンドでネットワークの仕組みを理解する

LAN(Local Area Network)

TCP/IP(Transmission Control Protocol/Internet Protocol)
インターネットで使われるプロトコル
TCPプロトコルとIPプロトコルを一緒に使うことを意味

MACアドレス(イーサネットにおける識別番号)
イーサネットはLANで使われているプロトコル
データの送信者と受信者をMACアドレスで識別

### ネットワークコマンド

```
ifcofig  #ネットワークのインターフェースの情報(ネットワークインターフェース毎に一塊となって出てくる)
以下省略

アルファベットがインタフェースの種類
後の数字が接続した順番を表す
```

|インターフェース名|概要|
| ----| ---- |
|lo|ローカルループバック。自分自身のIPアドレス(localfosat)|
|en|イーサネット。wifiや有線LAN|
|gif|トンネルデバイス(Generic tunnel interface)。IPv4とIPv6を繋ぐ|
|stf|Six to Four.IPv6からIPv4に変換する|
|awdl|Apple Wireless Direct Link。IOSとの通信、iphoneと接続するなど|
|p2p|awdlと類似した機能|
|bridge|Dockerを使ったサーバー|


自宅や企業内のネットワークLAN
インターネットのように企業と企業の間を結ぶネットワークのことをWAN

ルーターがLANをWANにつなぐ
ルーターの先はプロバイダのルーターにつながっている
プロバイダーのルーターから先はまた別のルーターで、他のプロバイダや他の企業につながっている
自宅や企業内のLANを１つの単位とし、それをプロバイダのルーターで他のLANと繋ぐことを世界的に広げていったものがインターネット
LANという小さなネットワークが結ばれて大きなネットワークになる

### MACアドレスを見る
LANとWANではプロトコル(規約)が異なる
異なれば送信者と受信者の識別番号も異なる
LANのプロトコルとして使われるイーサネットというプロトコルではMACアドレスが識別番号
MACアドレスは、ネットワークのハードウエアに割り当てられる

### IPアドレスとサブネット・マスクを見る
MACアドレスだけでは識別を行うのは面倒なため
データの送信者と受信者を郵便番号のように整然とグループ化して識別する必要がある
そこでインターネットで使われるIPプロトコルではIPアドレスを設定
ネットワークに接続されたパソコンやプリンタなどには、MACアドレスとIPアドレスの両方が設定されている
LAN用がMACアドレスで、WAN用(インターネット用)がIPアドレス

IPアドレスの上位桁は、ネットワークの識別番号(LANの識別番号) ＝ ネットワーク・アドレス

下位桁は、ホスト(通信機器を持ったパソコン、プリンタ、ルーターなどの機器)の識別番号 ＝ ホスト・アドレス

### DHCPサーバの役割を知る
DHCPとは動的にホストを設定するプロトコル
DHCPサーバーとは、DHCPを使って、ホストにIPアドレスとサブネット・マスクなどを自動的に設定
DHCPサーバーはLAN内のコンピュータに割り当てられるIPアドレスの範囲とサブネット・マスクの値などを記憶
新たなホストをLANに接続すると、DHCPサーバーから、他のホストに割り当てられないIPアドレスが知らされる

デフォルトゲートウェイは、LANとインターネットを繋ぐ最初のルーター
DNAサーバーの役割は、ドメイン名に対応するIPアドレスを知らせるサーバー

### TTLの役割を知る
TTLの値は、ルーターを一つ経由するたびに１ずつ減らされ、0になるとデータが破棄されるようになっている

それによって、データが永遠にインターネットを彷徨い続けることを防ぐ

これがTTLの役割

TTLの初期値は使用しているOSや設定によって違いがあり、64,128,255などがある
仮に首相官邸のWebサーバーのTTLの初期値が255だとしたら、応答がTTL=241の場合
255-241=14のルーターを経由していると推測できる

### DNSサーバーの役割を知る

インターネット上には、ドメイン名とIPアドレスの対応を記憶しているDNSサーバーが配備されている

```
ping ドメイン名
```

でドメイン名を指定するとPINGを送る前にDNSサーバーにドメイン名に対応するIPアドレスを教えてという問い合わせが行われ、その応答として得られたIPアドレスにPINGが送られる

ドメイン名をIPアドレスに変換することを名前解決と呼ぶ
インターネット上には、数多くのDNSサーバーがある
１つのDNSサーバーで名前解決ができない場合は他のDNSサーバーへ問い合わせるようになっている

### IPアドレスとMACアドレスの対応

LANとLANの間を繋いだものがインターネット
LANとインターネットでは、プロトコルが違うので送信者と受信者の識別番号も違う

イーサネットのLANの識別番号はMACアドレス

インターネットの識別番号はIPアドレス

IPアドレスからMACアドレスにどのように対応付けるのか？
インターネットからLANに入ったら、識別番号をIPアドレスからMACアドレスに変換するにはARP(Adress Resolution Protocol、アープ)という仕組みで実現される

ARPの仕組みはLAN内の全てのホストに向かってIPアドレスの検索をしあればMACアドレスを返してという問い合わせを行う

LAN内の全てのホストに問い合わせること（ブロードキャスト）
ブロードキャストに対して何らかのホストが応答してきたら、IPアドレスをMACアドレスに変化できる

### TCPの役割とTCP/IPネットワークの階層

TCP/IPとはTCPとIPの２つのプロトコルを使用していること

IPは、データの送信者と受信者をIPアドレスで識別していく
いくつかのルーターを経由してデータを送るためのプロトコル

TCPは、データの送信者と受信者がお互いに相手の確認をとりながら、確実にデータを受け渡すためのプロトコル(ハンドシェイク)

プロトコルは、通信における約束事
送信者と受信者が同じ約束事を守るからこそ、相互にデータが送り合える
約束事を守るとは、決められた形式のデータを決められた手順で送ること

私たちがキーボードから打ち込んだメールの文章などのデータ(アプリケーション・データ)はそのまま送信されるわけでない。
TCP ,IP,そしてイーサネットも約束事を守るための情報である「TCPヘッダ」「IPヘッダ」「イーサネットヘッダ」が付加されて送信される。
ヘッダには、それぞれのプロトコルで送信者の識別情報などがある
ヘッダは宅配便の送り状のようなもの。

#### インターネットでやりとりされるデータの構造
TCPの識別番号は「ポート番号」と呼ばれる
MACアドレスにIPアドレスがホストを識別するのに対し、ポート番号はWebブラウザやメールソフトなどのプログラムを識別する

|イーサネットヘッダ|送信者と受信者のMACアドレスなど|
| ---- | ----|
| IPヘッダ | 送信者と受信者のIPアドレスなど |
|TCPヘッダ|送信者と受信者のポート番号など|
|アプリケーション・データ|メールの文章などのデータ|

#### ネットワークの仕組みは、階層化
私たちが作成したデータは、TCPの階層→IPの階層→イーサネットの階層とたどって、ケーブルから送信される
階層を辿る際にそれぞれのヘッダが付加される
逆に、ケーブルから受信したデータは、イーサネットの階層→IPの階層→TCPの階層とたどって、アプリケーションに渡される
階層を辿る際にそれぞれのヘッダが除去される





