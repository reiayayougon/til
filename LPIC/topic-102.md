## RPMとYUMパッケージ管理

RPM：Red Hat Linuxディストリビューション及びその派生で使用されるパッケージ管理システムの一つ。rpmコマンドを使用してパッケージを操作する

YUM：RPMパッケージ管理を簡素化し、依存関係の解決を補完するための￥に作成されたパッケージ管理ユーティリティ。YUMは、Red Hat Linuxベースのディストビューションで広く使用されている。yumコマンドを使用して、パッケージの取得、インストール、アップグレード、削除などの操作を行う。
YUMはリポジトリと呼ばれるパッケージの保存場所からパッケージをダウンロードして管理する。

要するに、RPMはパッケージの形式であり、YUMはそのパッケージを管理し、必要に応じて依存関係を解決してシステムに適切に適用するためのツール。

yumコマンドは、インターネット上ないしはメディア上のパッケージ情報のデータベースを使い(YUMがパッケージ情報を取得する手段がインターネットである場合と、ローカルのメディアである場合の両方)、依存間毛を調整しながら、パッケージのインストール・アンインストールなどを行えるコマンド。

|サブコマンド|説明|
|----|----|
|install|パッケージのインストール|
|update|パッケージのアップデート|
|remove|パッケージのアンインストール|
|info|パッケージの詳細情報|
|list|パッケージの一覧情報|
|search|指定したキーワードでパッケージの検索|
|check-update|アップデート可能なパッケージの表示|
|grouplist|パッケージグループの一覧表示|
|groupinstall|パッケージグループのインストール|


zypperコマンドはopenSUSE(SUSE Linuxから改名)が採用されているコマンドラインのパッケージ管理ツール。aptコマンドやyumコマンドのように、zypperコマンドでリポジトリやパッケージの操作を行える。


Linuxで使用するパッケージとは、ソフトウエアの実行ファイル、設定ファイル、ライブラリ、マニュアルなどが含まれているファイルのこと。パッケージ及びその管理ツールを使用することによって、ソフトウエアのインストール・アンインストールなどが容易にできるようになる。

Red Hat Linuxが開発したパッケージにRPM(Red Hat Package Manager)形式がる。現在はRed Hat EnterpriseLinux(RHEL)、CentOS、openSUSEなど、多くのディストリビューションが使用してしてる。
RPM形式のパッケージファイル名は以下のような形式
```
パッケージ名_バージョン番号_リリース番号_アーキテクチャ名.rpm
```

rpmはRPM形式のパッケージファイルのインストール・アンインストールなど基本的なパッケージ管理を行うコマンド
rpmコマンドのインストール関連の主なオプション
|オプション|説明|
|----|----|
|-i|パッケージのインストール|
|-U(--upgrade)||
|-F|(--freshen)|パッケージのアップグレード(なければしない)|
|-e(--erasw)|パッケージのアンインストール|
|-v|詳細情報の表示|
|-h(--hash)|進行状況を#で表示|
|--test|実際に実行はせずにテストを実行|
|-nodeps|依存関係を無視|


rpmコマンドを使用して、インストール前にファイルからインストールされているファイルを調べたい時
```
rpm -qlp
rpm ---quesry --list --package
```
-q(--query)指定したパッケージがインストールされているかを確認
-l(--list)指定したパッケージに含まれるファイルの表示
-p(--package)照会対象をパッケージファイルとする

RPM形式のパッケージ管理ツールは以下の２つがある
#### RPMツール
RPM系パッケージを管理する基本的なツール。設定ファイルは/usr/lib/rpm/rpmrc。
RPMツールの主なコマンド
- rmpコマンド
パッケージのインストール・アンインストールなど、基本的なパッケージ管理を行うコマンド
(Debian系Linuxでは、dpkgがほぼ同等のコマンドに当たる)

- [ ] rpmコマンドの-Vオプションについての説明
- [ ] 検査する内容は主にファイルサイズ、MD5チェックサム、所有ユーザ、所有グループ、タイムスタンプである

RPMデータベースに格納されているファイルに関する情報と、インストールされたパッケージのファイルに関する情報を比較して変更(改ざんなど)が無いか検査する


- rpm2cpio
RPM系パッケージをcpio形式のアーカイブに変換する

#### YUMツール
YUMツールはRPMツールを拡張したツール群。インターネット上ないしはメディア上のパッケージ情報のデータベースを使い、依存関係を調整しながらパッケージ管理を行うことができる。
設定ファイルは、/etc/yum.conf、パッケージの取得元(リポジトリ)は/etc/yum.repos.dディレクトリ内のファイルで設定する。リポジトリ情報を追加するには/etc/yum.repos.dにリポジトリの情報を記述した拡張子.repoのファイルを配置する。
YUMには組み込み変数が用意されており、yumコマンドや設定ファイル内で使用できる。例えば、設定ファイル内のパッケージ取得用URLには「$releasever」や「$basearch」などの組み込み変数が記述されている。

YUMツールの主なコマンド

- yumコマンド
パッケージのインストール・アンインストールなどを行うコマンド(Debian系Linuxでは、apt-getがほぼ同等のコマンド)

YUMツールのリポジトリの設定について
- ネットワーク経由で、依存関係を解決しながら最新のパッケージを取得できる
- 各リポジトリごとの詳細設定ファイルを/etc/yum.repos.dディレクトリ内に配置する
- リポジトリの設定ファイルでは変数$releaseverと$basearchを活用している

yumコマンドの後継であり、yumと同様のオプションやリポジトリを使用できるコマンド
```
dnf
```
DNFはYUMの後継となるパッケージ管理ツール。Linuxディストビューションの一つであるFedoraでは、Fedora 22からデフォルトのパッケージ管理ツールになっている、
dnfコマンドではyumコマンドとほぼ同じオプションが使用できる。
また、リポジトリ(パッケージの取得元)もyumと同様に/etn/yum.repos.dディレクトリを使用。



#### DNFツール
YUMの後継となるパッケージ管理ツール。Linuxディストビューションの一つであるFedoraでは、Fedora 22からデフォルトのパーケージ管理ツールになっている。
dnfコマンドでは、yumコマンドとほぼ同じオプションが使用できる。リポジトリも同様のディレクトリを使用。

#### Zypperツール
ZypperはopenSUSEが採用してるコマンドラインのパッケージ管理ツール。
aptコマンドやyumコマンドのように、zypperコマンドでリポジトリやパッケージの操作を行える。

RPM系パッケージをcpio形式のアーカイブに変換するコマンド
```
rpm2cpio
```

cpio形式は、ファイルのアーカイブと複製に使用されるデータ形式。cpioは、ファィルとディレクトリの階層構造を保持しつつ、これらのデータをアーカイブ化及び復元するためのユーティリティであり、通常、tarと同様の目的で使用される。
cpio形式ののアーカイブは、バイナリデータとして表現され、ファイルとディレクトリの情報、パーミッション、タイムスタンプなど含まれる。cpioは、データをバックアップしたり、ファイルを他の場所に複製する際に使用される。

### Debian
dpkgはDebian形式のパッケージのインストール・アンインストールなど、基本的なパッケージ管理を行うコマンド
dpkgコマンドのオプション・アクション
|オプション|説明|
|-E|同バージョンがすでにインストールされていればインストールを行わない|
|-R|ディレクトリを再起的に処理|
|アクション|説明|
|-i(--install)|パッケージのインストール|
|-r(--remove)|設定ファイルを残してパッケージをアインインストール|
|-P(--purge)|設定ファイルも含め完全にパッケージをアンインストール|
|-s(--status)|インストール済みパッケージの詳細情報の表示|

apt-cacheはDebian形式のパッケージ情報の検索・参照などを行うコマンド
apt-cache サブコマンド

|サブコマンド|説明|
|----|----|
|search|キーワードを含むパッケージを検索|
|show|指定したパッケージ情報の表示|
|showpkg|指定したパッケージの非依存関係を含めた情報の表示|

apt-getコマンドは、インターネット上ないしはメディア上のパッケージ情報のデータベースを使い、依存関係を調整しながら、パッケージのインストール・アンインストールなどを行えるコマンド
apt-get [オプション] サブコマンド
|サブコマンド|説明|
|----|----|
|install|指定パッケージのインストールまたはアップグレード|
|remeove|指定のパッケージのアインストール|
|dist-upgrade|システム全体(全パッケージとカーネルのアップグレード)|

apt-getコマンドのupdateとupgradeサブコマンドの説明
upgradeは全パッケージのうち、既存パッケージの削除や新規パッケージの追加をせずに更新できるものについて、アップグレードする
updateはパッケージのデータベースを最新版に更新する

#### aptコマンド
パッケージのインストール・アンインストールなどを行うapt-getコマンドとパッケージ情報の検索・参照を行うapt-cacheコマンドの機能を統合したコマンド

## ブートマネージャのインストール
ブートローダーは記憶装置内のカーネルをロードし、カーネルに制御を移す役割。
ブートローダーは第一段階と第２段階に分かれている。
第一段階の部分はMBR(Master Boot Record)に格納、
第二段階部分は記憶装置内(HDD)の別の場所に格納されている。
第一段階のブートローダーはMBRの先頭446バイトの領域にインストールされている。
Linuxで使用するブートローダーには主にGRUB(GRand Unified Bootloader)がある。
GRUBは多くのファイルシステムに対応しているこう機能なブートローダー。GRUBには操作を対話的に行うことができるGRUBシェルと呼ばれるプログラムが付属している。
GRUBのインストールにはgrub-installコマンドを利用。



GRUB2は多くのLinuxディストリビューションや他のオペレーティングシステムで使用されるブートローダー。コンピュータの起動プロセスを制御し、オペレーションシステムの選択、起動オプションの指定、及びカーネルの起動を可能にする。

GRUB2でパーティションを指定する際は、「(hdディスク番号、パーティション番号)」のように指定する。
ディスク番号は0から、パーティション番号は1から数える。

例）
１番目のディスクの１番目もパーティション→(hd0,1)

GRUB Legacyの設定ファイル/boot/grub/menu.lstにおいて、ルートパーティションを２番目のディスクの３番目のパーティションに指定したい場合
root (hd1,2)

GRUB Legacy (GRUB1)の設定ファイル
/boot/grub/menu.lstでルートパーティションを指定するにはroot(hdディスク番号、パーティション番号)と指定。その際番号はどちらも0から数える。

*****まとめ*******
ブートローダーでさるgrubのバージョンが0.9x系のものをGRUB Legacy、1,9以降のものをGRUB2と呼ぶ。
GRUB Legacy(GRUB1)の設定ファイルは「/boot/grub/menu.lst」、ディストビューションによっては「/boot/grub/grub.conf」
GRUB2の設定ファイルでは/boot/grub/grub.cfg
GRUB Legacyの設定ファイルでルートパーティションを指定するには、root(hdディスク番号、パーティション番号)と指定する。その際、番号はどちらも０から数える。
GRUB2でパーティションを指定する際は、(hdディスク番号、パーティション番号)のように指定。ディスク番号は０から、パーティション番号は１から数える。


## 共有ライブラリとは

ライブラリとは汎用性の高いプログラムを再利用かのな形にしてまとめたもの。ライブラリそれ自体を単独で実行することはなく、他のプログラムに組み込んで呼び出すこと、ライブラリの持つ機能を利用できるようになる。
複数のプログラムから参照して使えるようにしたものを「共有ライブラリ」という。

動的リンク(ダイナミックリンク)：プログラムの実行時に共有ライブラリを呼び出すこと
静的リンク(スタティックリンク)：プログラムのコンパイル時にライブラリの機能を実行ファイル内に埋め込むこと

```
環境変数LD_LIBRARY_PATH   #共有ライブラリの検索パスを指定するための環境変数
```

```
/etc/ld.so.cache  #共有ライブラリを検索するためのバイナリファイル。lsconfigコマンドを使用して作成
```

```
/libと/usr/libディレクトリ
一般的に使用される共有ライブラリは/libと/usr/libディレクトリに格納されている
```

つまり/libや/usr/libディレクトリ以外に配置する場合は、以下のいずれかの方法で共有ライブラリの検索パスを設定する必要がある。
- [ ] 環境変数LD_LIBRARY_PATHに検索パスを追加する
- [ ] /etc/ld.so.confファイルに検索パスを追記してldconfigコマンドで/etc/ld.so.cacheファイルを更新(作成)する


|コマンド|インストール|
|----|----|
|dpkgコマンド|-i/--install|
|dpkgコマンド|-Ri/-R --install(パッケージをまとめてインストール)|
|rpmコマンド|-i/-U(なければインストールする)|
|zypperコマンド|install/in|

|コマンド|パッケージの詳細情報|
|rpm|--query -qip|

|コマンド|パッケージの一覧表示|
|----|----|
|yumコマンド|list|
|zypper|search/se(指定したキーワードでパッケージの検索)|



|コマンド|ファイルの一覧表示|
|----|----|
|dpkp|--listfiles -L|

|コマンド|パッケージの削除|
|----|----|
|rpm|--erase --nodeps(依存関係を無視)/-e -nodeps|

## 仮想化のゲストOSとしてのLinux

クラウドインスタンスを展開するためにインスタンスの構成やカスタマイズを行えるLinuxのパッケージ
```
cloud-init
```

IaaS(Infrastructure as a Service)は、サーバ、ストレージ、ネットワーク等、仮想化されたインフラ環境をサービスとして提供する、サーバの仮想化技術と関連が深いサービスモデル。

利用するサービスモデルによってクラウド環境へのLinuxの展開方法が変わってくる。
IaaSは、クラウドサービス側ではハイパーバイザー型の仮想環境を提供し、ユーザは「インスタンス」と呼ばれる仮想マシンにOSをインストールして使用。
なお、クラウド上のインスタンスはテンプレートから展開されるため、テンプレートから複製された環境を重複しないようにインスタンスごとに変更する必要がある。この作業をまとめて行う「cloud-init」というパッケージが用意されている。cloud-initパッケージはクラウド上でなくても、インストールして使うことができる。

#### 仮想化とは
仮想化とは、コンピュータリソースを実際の物理的な構成にとらわれず、論理的に分割・統合して提供する技術。仮想化の対象となるコンピュータリソースにはサーバやOS、ストレージ、ネットワークなどがある。

仮想化の種類

- ハイパーバイザー型
物理マシン上で動作するハイパーバイザー(仮想化のための専用のOS)上で直接仮想マシンを起動し、ゲストOS(仮想マシンにインストールしたOS)を動作させる方式。物理マシンのハードウエアをエミュレート(模倣)する完全仮想化を実現できる。
ゲストOSからは通常の物理マシン上で操作しているように見えるため、これまでのサーバにOSをインストールしているのと同様の環境を構築できる。ハイパーバイザーがサポートしている種類のゲストOSであれば、LinuxやWindouws、macOSなども使用できる。
ハイパーバイザー型の仮想化ソフトウエアには、Xenや、KVMなどがある。

- コンテナ型
OSのリソースを「コンテナ」という単位で隔離して共有する方式。OS上のアプリケーションと同じレベルの扱いなので、オーバーヘッドが少なく、リソース・構築・管理の面で非常にシンプルになる。
コンテナ仮想化では、Linuxカーネルの機能によってコンテナごとのユーザ管理やリソース制限を行う。
コンテナ型ソフトウエアには、LXC、Dockerなどがある

クラウドで提供する仮想化環境について
- ブログサービス環境などのように、ユーザの用途に応じて利用可能なコンテナをアプリケーションコンテナと呼ぶ

- 仮想マシンのことをインスタンスと呼ぶ
- 仮想マシンへのOSのインストールはテンプレートを利用できる

クラウドストレージとは
サーバー/ストレージ/アプリケーションなどのリソースを全てクラウドに置き、
それらのリソースをサービスとして利用するコンピューティング環境。
クラウドコンピューティングでは、仮想化技術によって物理的な制約を回避し、迅速、柔軟に、必要な時に必要な分だけコンピューティングリソースをサービスとして利用できるようになっている。

クラウドサービス側でハイパーバイザー型の仮想化環境を提供する場合、
ユーザは「インスタンス」と呼ばれる仮想マシンにOSをインストールして使用。
OSのインストールは、あらかじめ用意されたテンプレート(OSイメージ)から行うのが一般的。
クラウドサービス側でコンテナ型の仮想化環境を提供する場合、ユーザは仮想環境上で動作する「コンテナ」を利用することになる。また、ユーザが利用するコンテナ環境を選択できる場合もある。
このようにアプリケーションとして利用可能なコンテナは「アプリケーションコンテナ」と呼ばれる。
アプリケーションコンテナの例として、Webサーバやデータベースサーバが組み込まれたブログサービス環境などある。

#### ブートマネージャーのインストール
ブートローダであるGRUB LegacyまたはGRUB2をインストールするコマンド
```
grub-install
```

GRUBのバージョンが0.9x系のものをGRUB Legacy
1.9以降のものをGRUB2と呼ぶ



### Debianパッケージ管理

dpkgツールに置いてインストール済みのパッケージを、インストールした時と同じように際設定するコマンド
```
dpkg-reconfigure
```

```
dd if=/dev/zero of=/dev/sda bs=446 count=1
結果としてブートローダのみがゼロクリアされる
```
GRUBに代表されるブートローダーはHDDの最初のセレクタ(512バイト)にあるMBR(マスターブートレコード)に格納される。MBRは以下のように使用する領域が決まっており、ブートローダは先頭の466バイトの領域に格納されていうる。
ブートストラップローダー(446バイト)
第一パーティション情報(16バイト)
第二パーティション情報(16バイト)
第三パーティション情報(16バイト)
第四パーティション情報(16バイト)
ブートシグニチャ(2バイト)
合計：512バイト

*****解説********
ddコマンドはデータをコピーするコマンド
if(入力ファイル)オプション「/dev/zero」を指定するとnullであるデータであるファイルが作成され、of(出力ファイル)オプション「/dev/sda」のデータが上書きされる。bs(ブロックサイズ)オプションに446が指定されているため、ブートローダ部分のみがゼロクリア(消去)される。count=1はコピーする回数。


### LVM
LVM(Logical Voliume Manager)は、物理的な記憶デバイスの領域(物理ボリューム：PV)を複数にまとめて一つの大きな仮想敵に領域(ボリュームグループ：VG)とし、そこから仮想的なパーティション領域(物理ボリューム：LV)を切り出すことで、従来の物理的なパーティションを用いた方法よりも柔軟に記憶領域を管理することができるようにする仕組み。

- 物理ボリューム(PV)
物理的なハードディスクやパーティション

- ボリュームグループ(VG)
物理ボリュームを集めて作る、仮想的な領域(仮想的なハードディスクのようなもの)

- 論理ボリューム(LV)
ボリュームグループの一部(または全部)を使って作る、仮想的なパーティション。従来のパーティションと同じように、この論理ボリューム上にファイルシステムを作って利用可能。

論理ボリュームを作成する手順
物理ボリュームの作成(PV)
pvcreateコマンド
↓
ボリュームグループの作成
vgcreateコマンド
↓
論理ボリュームの作成
lvcreateコマンド




