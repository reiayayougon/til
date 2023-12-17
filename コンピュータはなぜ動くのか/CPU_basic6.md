## 6章
### データ構造と仲良くなる７つのポイント
#### ポイント1 メモリーと変数の関係を知る
パソコンにはメモリーの内部が８ビット(=1バイト)ごとのデータかくない領域に区切られていて、それぞれの領域を区別するために番号がある(アドレス/番地)
アドレスを指定してプログラムを書くのは面倒なので、プログラミング言語では変数を使ってメモリーにデータを格納したり、メモリーからデータを読み出す

#### ポイント２ データ構造の基本となる配列を知る
配列はデータ構造の基本
配列がメモリーの物理構造そのものだから
メモリーにはデータを格納するための領域が連続的に並んでいる。プログラムは、メモリー全体の中から必要な領域を確保していく。これをプログラムの構文で表すと配列になる。

#### ポイント３ 定番アルゴリズムで配列の使い方を知る
配列を使えば、大量のデータを処理するさまざまなアルゴリズムをプログラムで実現できる

**配列xに格納された1000個のデータの中から777を見つける**
```
for i in 0..999
 if x[i] == 777
   puts "#{i}番目に見つかりました\n"
   break
  end
end
```
**昇順バブルソート**
```
for i in 0..998
 for j in 999.downto(i+1)
   if !(x[j - 1] > x[j])
    temp = x[j]
    x[j] = x[j -1]
    x[j - 1] = temp
  end
end
end
```
#### 定番データ構造のイメージを掴む
|名称|データ構造の特徴|
| ---- | ---- |
| スタック(LIFO) | データを山のように積み上げる |
| キュー(FIFO) | データを行列のように並ばせる |
| リスト | データの並びを任意に変更できる |
| ２分木 | データの並びを二またに分ける |

#### ポイント５ スタックとキューの実現方法を知る 
スタック
```
class Stack
  def initialize
    @stack = []
  end

  def push(data)
    @stack.push(data)
  end

  def pop
    @stack.pop
  end
end
```
```
stack = Stack.new

stack.push('A')
stack.push('B')
stack.push('C')

puts stack.pop # 'C'
puts stack.pop # 'B'
puts stack.pop # 'A'
```

キュー
```
class Queue
  def initialize
    @queue = []
  end

  def enqueue(data)
    @queue.push(data)
  end

  def dequeue
    @queue.shift
  end
end
```
```
queue = Queue.new

queue.enqueue('A')
queue.enqueue('B')
queue.enqueue('C')

put queue.dequeue  # 'A'
put queue.dequeue  # 'B'
put queue.dequeue  # 'C'
```

#### ポイント６ 構造体の仕組みを知る
構造体:複数のデータを一つにまとめたもの

構造体メンバー:構造体にまとめられた個々のデータ

#### ポイント７ リストと２分木の実現方法を知る

リストは、要素が順番につながったデータ構造で、各要素はデータと次の要素へのリンク（参照）を持つ
二分木とは、各ノードが最大で２つの子ノードを持つ木構造のデータ構造。各ノードには値が格納され、左の子ノードと右の子ノードが存在する場合がある。これにより、ノードは木構造を形成し、左側の子ノードは親ノードよりも小さな値を持ち、右側の子ノードは親ノードよりも大きな値を持つ。
```
        5
       / \
      3   7
     / \ / \
    2  4 6  8
```




#### Rubyの基本 
配列を使って木を作る
```
leaf_a = ["葉A"]
leaf_b = ["葉B"]
leaf_c = ["葉C"]
leaf_d = ["葉D"]
#部分木
node2 = ["節2", leaf_a, leaf_b] #左側の木
node3 = ["節3", leaf_c, leaf_d]  #右側の木
node1 = ["節1", node2, node3]   #根
#根を直接定義すると
node1 = [
  "節1",
  ["節2",["葉A"],["葉B"]],
  ["節3",["葉C"], ["葉D"]]
]
```
木を分解する
根の名前を取り出す
```
p(node1[0])  #=> "節1"
```
左側の木を取り出す
```
node2 = node1[1]
p(node2) #=> ["節2",["葉A"],["葉B"]]
```
右側の木を取り出す
```
node3 = node1[2]
p(node3) #=> ["節3",["葉C"], ["葉D"]]
```
木を操る
```
def preorder(tree)
  p(tree[0])  #各部分木でやりたいこと
  if tree[0].start_with?("節")      #start_withメソッドはRubyの文字列(string)クラスに属するメソッドで、指定した文字列で始まるかどうか判定
　　　preorder(tree[1])
     preorder(tree[2])
  end
end
node1 = ["節1", ["節2", ["葉A"], ["葉B"]], ["節3", ["葉C"], ["葉D"]]]
preorder(node1)

C:¥Ruby > ruby tree-names.rb ⏎
"節1"
"節2"
"葉A"
"葉B"
"節3"
"葉C"
"葉D"
```



