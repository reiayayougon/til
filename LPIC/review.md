yumコマンドを使用してパッケージグループの一覧表示
```
yum grouplist
```

「Rebooting in 10 minutes」表示して、23:00時にサーバーを再起動する
```
shutdown -r 23:00 Rebooting in 10 minutes 
shutdown -r +10 Rebooting in 10 minutes

#rebootコマンドはシステムを再起動するが時間及びメッセージを指定することはできない
```

rpmコマンドを使用して、postfix-1.1.12-1.i386.rpmファイルからインストールされる設定ファイルのみ表示
```
rpm -qcp postfix-1.1.12-1.i386.rpm
rpm --query -cp postfix-1.1.12-1.i386.rpm

-q(-query) 指定したパッケージがインストールされているかどうかを紹介
-c(-configfile) 設定ファイルの一覧表示
-p(--package) 紹介対象をパッケージファイルとする
```

systemdが利用できるユニット一覧を取得するコマンド
```
systemctl list-unit-files
#稼働状況や起動設定を管理するにはsystemctkコマンド
```

initプログラムであるUpstartの特徴
- イベント駆動型
- サービスの並列起動処理が可能
- サービスやタスクをジョブ単位で扱う

upstartはsysvinitを改善した新しい取り組み。現在はsystemdへの置き換えが勧められている。
upstartではバックグランドで動作するデーモンプロセス(サービス)や、一度だけ実行させたい処理(タスク)をジョブと呼び、ジョブ単位で起動処理の管理を行う。
sysvinitのように順次起動していくのこと異なり、サービスの起動に必要な条件が成立した時点で起動処理が行われるため不要な待機時間がなくなる。また、各ジョブの実行がパラレル(並列)に行われるため、関連のない独立したサービスは同時に起動させることができる。

zypperコマンドを使用して、emacsパッケージをアンインストールするコマンド
```
zypper remove emacs
zypper rm emacs
```
zypperコマンドを使用して、アップデート可能な全てのパッケージをアップデートするコマンド
```
zypper update
zypper up
```

zypperコマンドで、アップデート可能なパッケージを確認
```
zypper list-updates
zypper lu
```

zypperコマンドで、リポジトリの一覧を表示
```
zypper repos
zypper lr
```

zypperコマンドで、emacsパッケージをインストール
```
zypper in emacs
zypper install emacs
```
ブートローダであるGRUB Legacyの設定ファイル/boot/grub/menu.lstを編集した。変更内容を反映させるコマンド
```
実行するコマンドはない

実行することがあるのはGRUB2。
GRUb2の場合の設定ファイル/boot/grub/grub.cfgである。/boot/grub/grub.cfgを直接編集することはなく、設定内容は/etc/default/grubファイル及びetc/grub.dディレクトリ内のファイルに記述し、grub-mkconfigコマンドで設定内容を/boot/grub/grub.cfgファイルに反映させる

```

UEFIの特徴
```
- GTPというパーティション形式で対応しており、3TB以上のHDDから起動をサポートする
- 最初にアクセスされる領域であるESPは/boot/efiにマウントされる
- GUIでの操作が可能になる

UEFI(Unified Extensible Firmware Interface)は、IntelがBIOSを置き換えるために考案したEFIの統一仕様。GUIでの操作をサポートしてくれたり、ファームウエアが使用可能なメモリ量の上限が緩和されるなど、BIOSよりも高機能化している。

ESP(EFIシステムパーティション)はUEFIシステムに置いて、物理的なマシンを起動し、ファームウエアが読み込まれたあと、その後の起動シーケンスで最初にアクセスされる領域になる。
ESPは/boot/efiにマウントされる
```

一般的なLinuxシステムは、BIOS、ブートローダ、カーネル、initの順にブートプロセスが進行

### BIOS(Baisc I/O System)
最もハードウエアに近い部分を司るシステムで、物理的なハードウエア(マザーボード)上に書き込まれる。
コンピュータの電源を入れると、まずBIOSが起動し、記憶装置(HDD)等に関して最低限の認識をして起動デバイスの優先順位を決定。その後、優先順位に従って各デバイスの先頭セクタにあるMBR(ブート用の特殊領域。ブートローダが格納されている)を読み込み、得られたブートローダに制御を移す。

### ブートローダ
LinuxシステムではGRUBが該当。
MBRに次格納されている第一段階部分と、記憶装置内の別の場所に書くのされている第二段階部分がある。
分れている理由は、MBRには厳しいサイズ制限があるため。
ブートローダは記憶装置内のカーネルをロードし、カーネルに制御を移す役割を果たす。
第一段階のブートローダはMBRの先頭446バイトの領域にインストールされる。

### カーネル
カーネルは起動されると、行動にハードウエアを認識・制御し、ルートファイルシステムのマウントなど様々な初期化処理を行う。
ブートローダはカーネルと初期RAMディスク(initramfs)の内容をメモリ上に展開し、カーネルはメモリ上に展開された初期RAMディスク内の、ファイルシステムへアクセスするために必要なドライバやスクリプトを使用してルートファイルシステムをマウントする。その後、initという特別な最初のプロセスをルートファイルシステムから起動する。
カーネルイメージと、カーネルのバージョンに対応する初期RAMディスクは/bootディレクトリに格納される。初期RAMディスクは展開してイメージ内のディレクトリ、ファイルを参照することができる。

 ### init
最初に起動されるプロセスで、PID(プロセスID)は必ず１。
sysVinitと呼ばれる従来のinitプログラムを採用しているシステムでは/sibin/initが起動される。
initプロセスは設定ファイル/ect/inittabの記述に基づいて、自動起動するべきプロセスを立ち上げるなど。アプリケーションの初期化を行う。
以降、initプロセスは全てのプロセスの先祖(直接・間接的な呼び出しもと)として存在し続ける。
最近のシステムではinitプログラムとして、初期化処理を高速したupstartやsystemdを採用してる場合があるう。その場合は基本的に/etc/inittabファイルは使用しない。


接続されたUSBデバイスの情報を表示するコマンド
```
lsusb
cat /proc/bus/usb/devices
```

systemdが稼働するシステムにおいて、次回起動時のターゲットが確認できるsystemctlコマンド
```
get-default
```

デバイスが使用中のDMAチャンネルに関する情報が確認できるファイル
```
/proc/dma
```

DMAとは、CPUを介することなくメインメモリと周辺機器の間で直接的に情報転送を行う方式。
DMAチャンネルは周辺機器がDMAのコントローラ(制御装置)に対して情報転送を要求するために使用する通信経路のこと。
