xzコマンドでエラーを抑止して解凍する際のオプション
```
-qqd    #エラーを抑止するためにはqオプションを2回指定
```
xzコマンド  ファイル圧縮するコマンド
より大きくのCPU時間を使用して圧縮する際のオプション
```
--extreme
```
```
-vvd  #より詳細な情報を表示しながら解凍する際のオプション
```

dfコマンドで、人間が読みやすい形式のサイズで表示(1K,234M,2Gなど)するためのオプション

```
 -Hまたは--si
```

xはアーカイブファイルの展開、vは進行状況の表示、zはgzipで圧縮や展開を行う、fはアーカイブファイル名を指定するオプション

```
tar xvzf tar.gzファイル名 ファイルパス
```

ddコマンド 入力から出力へデータをコピーする
```
bs   #1度に読み書きするバイトを指定するオプション
```

fsckコマンド ファイルシステムにエラーがないかどうかのチェックと修復を行う

grepコマンド パラメーターで指定されたパターンを検索し、一致する各行を標準出力に書き出す

dpkgとはDebian Packageの略で、パッケージを管理するコマンド
インストールは行わずにパッケージを展開する場合のオプション

```
--unpack
```

chainloader(チェインロード)とは、ブートローダからブートローダをロードすること。

mkfsコマンド 新しいファイルシステムを作成
```
mkfs.exfat -n DATA /dev/sdb1   #DATAというラベルをつけてexFATノファイルシステムを作成
```

rmpコマンド
```
どのパッkケージからインストールされたか表示
-qf   #オプション qはインストール済みパッケージの照会、fは対象ファイルを指定するオプション
```

fdiskコマンド ハード・ディス領域を分割して複数のパーティションを作成・編集できるコマンド

xfs_repairは破損または破損したXFSファイルシステムを修復する

PCIとはデスクトップパソコンの機能を拡張するため「拡張カード」を接続するための規格
```
lspci  #PCI接続されているデバイスを確認できるコマンド
```

GPTとMBRは、コンピュータのストレージデバイス(ハードディスクやSSDなど)上でデータを管理し、ブートローダーやパーティション情報を格納する際に使用されるディスクパーティショニング方式

```
mklabel gpt    # partedコマンドの対話モードでGPT方式のパーティションテーブルを作成するコマンド

partedコマンド MBRとGPTの両形式に対応した、パーティションの作成や削除などに使う

help mklabel   # ラベルにしてできるタイプを確認できるコマンド
```

grub.confできそうファイルを指定するパラメータはkernel


