### マウント・アンマウント

現在マウントされているファイルシステムを確認するコマンド
```
mount
cat /proc/self/mounts
cat /etc/mtab
```

mountコマンドは、デバイスとマウント先どちらもしてしなかった(mountのみ実行した)場合は、現在マウントされているファイルシステム一覧が、/etc/mtabファイルの情報を元に表示される。
また、Linuxでは/procディレクトリの配下に様々なリソース情報が収められている。
/proc/self/mountsと/proc/mountsファイルにも現在マウントされているファイルシステムの情報が格納されている

umountコマンド アンマウントを行う

|オプション|説明|
|----|----|
|-a|/etc/mtabファイルに記載されているファイルシステムを全てアンマウント|
|-t|指定した種類のファイルシステムのみをアンマウント|

-at xfsオプションを指定すると、現在マウントされている(/etc/mtabファイルシステムに記述されている)
xfs形式のファイルシステムを全てアンマウントする

### パーミッション

chmodコマンド ファイルやディレクトリのパーミッションを変更する

-Rオプションを使用すると、指定したディレクトリ及びその配下にあるファイルのパーミッションを変更することができる

dirディレクトリ及びその配下にあるファイルのパーミッションを755に設定するコマンド
```
chmod -R u=rwx, go=rx dir
chmod -R u=rwx, go-w dir
chmod -R 755 dir
```

パーミッションの指定には数値か記号を用いる

記号

|対象|説明|
|u|所有者|
|g|所有グループ|
|o|その他ユーザ|
|a|全てのユーザ|
|操作|説明|
|+|権限を追加|
|-|権限を削除|
|=|権限を指定|
|権限|説明|
|r|読み取り権|
|w|書き込み権|
|x|実行権|
|s|SUIDまたはSGID|
|t|スッティキービット|

#### デフォルトパーミッションとumask値

新規に作成されるファイルやディレクトリのデフォルトのパーミッションは、システムで定められているパーミッションの初期値を基本とし、それをumask値で調整することで決定される
umask値は、システムのパーミッション初期値から、どの権限を削除するかを定義する設定
通常/etc/basshrcなどに設定されており、シェルの起動時にシステムのデフォルト値に戻る
umask値を~/.basgrcなどに設定することで、ユーザごとにも指定できる


プログラムfileをどのユーザが実行しても、プログラムを所有するグループの権限で実行させたい。
fileのパーミッションは755である。適切なコマンドは
```
chmod 2755 file
chmod g+s file
```

プログラムをどのユーザが実行しても、プログラムを所有するグループの権限で実行されるよにするためにはSGIDを設定する。
通常、プログラムが実行されると、そのプロセスは実行したユーザの権限で動作する。
しかしSGIDが設定されたプログラムの場合、プログラムは所有するグループの権限で動作する。
これにより複数のユーザが同じグループに所属している場合、それらのユーザが共有できる特定のファイルやリソースに簡単にアクセスできるようになる。
ディレクトリにSGIDを設定すると、そのディレクトリ内で新しく作成されるファイルやサブディレクトリも、親ディレクトリの所有するグループに設定される

設定方法は、chmodコマンドで通常のパーミッションの値に2000を加えた値を設定するか、グループにsという権限を追加


file.txtの所有グループのみをtestからstaffgroupに変更した時のコマンド
```
chown :staffgroup file.txt
chown staffgroup file.txt
chown .staffgroup file.txt
```

所有グループのみを変更するにはchownまたはchgrpコマンドを利用
ユーザが所属しているグループであれば、一般ユーザでも変更できる

/etc/fstabファイルでマウントオプションとしてdefaultsをした場合のオプション
```
async,auto,dev,exec,nouser,rw,suid
```
async 非同期で入出力を行う
auto mount -aコマンド実行時にマウント
exec バイナリの実行を許可
nouser 一般ユーザによるマウントを禁止
rw 読み書きを許可
suid SUIDとSGIDを有効化

SUID
ファイルに子もパーミッションが設定されると、そのプログラムを実行する際に、実行ユーザの権限ではなく、そのファイルを所有するユーザの権限で実行される。
通常は、ファイルを実行するとそのユーザの権限で実行されるが、SUIDがが設定されたファイルでは、ファイルを所有するユーザの権限で実行される

SGID
プログラムを実行する際に、実行ユーザのグループではなく、そのファイルを所有するグループの権限で実行される。
通常は、プログラムを実行すると実行ユーザのプライマリグループの権限で実行されるが、SGIDが設定されたファイルは、ファイルを所有するグループの権限で実行される。

### /etc/fstab

/etc/fstabファイルは、利用するファイルシステムのマウント設定を事前に行っておくファイル
/tec/fstabファイルの設定項目は６つ
一つ目の項目にはデバイス名を指定する
/dev/sda1のようにデバイスファイルシステムを書くか、ラベルやUUIDを使った指定を書く

ラベルを使うにはLABEL=/bootのようにLABEL=の後ろにラベルを書く
mount -aコマンド実行時にマウントされないマウントオプション指定はnoautoである

/etc/fstabファイルシステムを編集して、ext3ファイルシステムの/dev/sda1をシステム起動時から/bootに自動マウントするように設定したい
```
/dev/sda1 /boot ext3 auto 1 1
/dev/sda1 /boot ext3 defaults 1 1
```
システムは起動時にmount -a コマンドを実行し、/etc/fstabファイルにてマウントオプションのautoが設定させれているファイルシステムを全てマウントする。
つまり、autoが設定されているファイルシステムはシステム起動時に自動的にマウントされる
また、defaultsを指定した場合は、async,auto,dev,exec,nouser,rw,suidマウントオプションが指定されたことになる。

/dev/hdcとして認識されているCD-ROMドライブを/mnt/cdromにマウントしたい。
なお、実現するためのエントリは既に/etc/fstabファイルに追加してある
```
mount /dev/hdc
mount -t iso9660 /devhdc /mnt/cdrom
mount /mnt/cdrom
```

mountコマンドの書式
mount [オプション] [マウントするデバイス] [マウントポイント]

iso9660は標準的なCD-ROMのファイルシステム

/etc/fstabファイルにあらかじめCD-ROMドライブのエントリが記述されていいるため、以下のように
[デバイス名]か[マウントポイント]のどちらか片方ふだけ指定すれば、もう片方は/etc/fstabが参照され自動的に決定される。

#### dumpフラグ
そのファイルシステムをdumpコマン(バックアップ用のコマンド)の対象とするかどうかを０か１かで書く。
０は対象外となり、１では対象になる。

#### fsckフラグ
起動時に自動的に行われるfsck(ファイルシステムチェック)の優先度を数字でかく。
数字が小さいものからチェックされていく。０は例外で、チェックを省く指定になる。


現在マウントされているファイルシステムの情報が格納されているファイルは
```
/etc/mtab
```

mountコマンドを引数及びオプションを指定せずに実行した場合、/etc/mtabファイルを参照して、現在マウントされているファイルシステムの情報を表示する。

ファイルシステムのマウント設定を記載するファイル
````
/etc/fstab
````

systemdのmountユニットは、ファイルシステムのマウントを管理するためのユニットです。
/etc/fstabファイルの内容をsystemdに統合するため、systemd-fstab-generatorという初期プログラムが各マウントポイントに対応するmountユニットを自動生成する。また、手動でマウントを行った場合は、マウントポイントと同名のmountユニットが生成され、生成されたmountユニットがsystemdによって管理される。





### umask値

ファイルの新規作成において、所有者が読み取り、書き込み可能で、所有グループ及びその他のユーザが読み取りのみ可能となるようなパーミッションを設定するためのumask値は
```
0022
```
umask値は、システムのパーミッション初期値から、どの権限を削除するかを定義する
新規のパーミッション初期値は666。
つまり全ユーザーについて、読み取り権限4+書き込み権限2がある状態。
必要なumask値は、以下のように算出。
なお、新規ファイル用のパーミッション初期値では既に実行権限１が削除されているため、umask値の格桁に実行権限１を加えても、加えなくても、作成されるパーミッションは同じになる。

ディレクトリに適した権限について
- 書き込み権限があるディレクトリ内で、ファイルやディレクトリを作成・削除できる
- 実行権限があるディレクトリに移動できる
- ディレクトリ内の内容を参照

アンマウントを行うには、umountコマンドを使う。
ファイルシステムのあるファイルが操作中の場合や、ユーザがファイルシステムないで操作している場合、そのファイルシステムはアンマウントできない。
また、そのファイルシステムをカレントディレクトリとしているプロセスがある場合も同じ。

umountコマンドを発行したが、使用中であるbusyを示すエラー表示された。
原因として
```
アンマウントしようとしているファイルシステムを、プロセスが使用している
アンマウントしようとしているファイルシステムに、ユーザがアクセスしている
```

指定したファイルまたはディレクトリの所有グループのみを変更するコマンド
```
chgrp
```
ファイルのディレクトリやパーミッションを変更するコマンド  #変更できるのはコマンド実行するユーザが所有するファイルやディレクトリのみ(rootユーザは除く)
```
chmod
```
ファイルやディレクトリを新規作成した際の、デフォルトのパーミッションを調整するコマンド
```
umask
```

プログラムfileをどのユーザが実行しても、プログラムの所有者の権限で実行させたい。
なお、fileのパーミッションは７５５である。適切なコマンドは
```
chmod 4755 file
chmod u+s file
```

プログラムどのユーザが実行しても、プログラムの所有ユーザ権限で実行されるようにするにはSUIDを設定
SUIDは特殊なパーミッションの一つ。
設定方法は、chmodコマンドで通常のパーミッションの値に4000を加えた値を設定するか、
所有ユーザにsという権限を追加する。

rootユーザとして、dirディレクトリ及びその配下にあるファイルの所有グループをstaffgropに変更したい。適切なコマンド
```
chgrp -R staffgroup dir
chown -R :staffgroup dir
```
所有グループのみ変更するにはchownまたはchgrpコマンドを利用する
設問のようにrootユーザであればどちらでも実行できるが、ユーザが所属しているグループであれば一般ユーザでも変更できる。

*書式*
chown -R :グループ名 ファイルまたはディレクトリ
chgrp -R グループ名 ファイルまたはディレクトリ

ーRオプションでしてしたディレクトリ及びその配下にあるファイルの所有ユーザやグループを再帰的に変更することができる

指定したファイルまたはディレクトリの所有ユーザやグループを変更するコマンド
```
chown
```

dirディレクトリ内において、自分以外のユーザが所有するファイルを削除できないようにしたい。
なお、dirディレクトリのパーミッションは755である、適切なコマンド
```
chmod 1755 dir
chmod o+t dir
```

あるディレクト内において、自分以外のユーザが所有するダイルを削除できないようにするにはスティッキービットをディレクトに設定する。
設定方法は、chmodコマンドで通常のパーミッションの値を1000を加えた値を設定するか、その他ユーザに
tという権限を追加する。

Linux上で、一般ユーザがmount/mnt/usbコマンドで特定のUSBメモリを/mnt/usbディレクトリにマウントして使用できるようにしたい、rootユーザとして事前作業は
```
USBメモリのUUIDを確認し、マウント設定のデバイス名のに記述する
/etc/fstabファイルにUSBメモリのマウント設定を記述する
```
設問のように、mountoコマンドでマウントポイントのみ指定でマウントするためには、
/etc/fstabファイルにマウント設定を事前に行っておく必要がある。
USBメモリのように外付けのドライブを接続する際、接続する順番や環境によって/devディレクトリ配下のどのデバイスファイルとしてマウントされるのかが定まっていない
そのため特定のデバイスをいつものように同じようにマウントしたい場合は、デバイスのUUIDを確認し、/etc/fstabのマウント設定のデバイス名に記述しておくと良い。
デバイスのUUIDは、
blkidコマンド
lsblkコマンドで確認できる。


