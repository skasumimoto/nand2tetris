平日1日の目安：1つ以上テストを通す
休日は3つ以上

## Ch01

- f内のfは×
- sel[2] = 10 → sel[0] = 0
- セレクタ：1要素ずつ分岐する。 → k = log2 n
- 変数名にそれまでの評価分を与えるとわかりやすい。＠DMux8Way,Mux4Way16
- 評価の順番を考える。＠DMux8Way,Mux4Way16
- headerでlengthを定義していれば、配列は変数名で参照できる（当たり前）。

## Ch02

- 全加算：和の半加算を2回→sum、各半加算のcarryのOr→carry
- 分岐はMuxで表せる
- 反転はただのNot。でも反転するかどうかは入力で分岐してる。
- x[i..j]の指定のため、A.5.3のバスを用いる。接続ピンの任意の幅を接続に指定できる。
- 定数であるtrue,falseがバスで使えることも、A.5.3に書いてある

## Ch03

- まずは図をそのまま書き起こす
- フィードバックループ：出力をフィードバックとしても流す
- DMuxはinを伝えるかどうか選択に使える
- sel = 101110 → sel[0..2] = 110
- RAM8をベースとしたメモリの再帰構造
- load（書き込み）とフィードバックにより、out(t) = inまたはout(t - 1)の関係が成り立つ
- inまたはout(t - 1)は、DFFが時間遅延という性質を持つことでフィードバックできる

## Ch04

- Pseudo:「偽りの、にせの、まがいの」
- レジスタはDとAの2種類がただ1つずつのみ存在する（レジスタはDかAか指定するだけ）
- @xで、Aレジスタにxを格納する。その後でAに操作があれば、Aは後の操作後の値となる。@xはAへの1操作に過ぎない
- Mにより、Aレジスタで指定したアドレスのメモリワードの値を参照する
- AにR0やR1などを格納することで、RAM[0]やRAM[1]を参照できる。R0..R15は、仮想レジスタとしてRAM[0]..RAM[15]を参照する、定義済みシンボル
- SP,LCL,ARG,THISのシンボルは、それぞれRAMアドレスの0から4を参照する定義済みシンボル
- SCREENとKBDもI/Oポインタとして定義済みのシンボル
- comp領域によって計算を行う関数を指定している
- JGTやJMPはjump領域のニーモニック。それぞれのニーモニックごとに効果が異なる
- ラベルシンボルはユーザ定義
- Dが1以上のときにジャンプする
- ユーザ定義の変数シンボルを参照することで、値ごとの処理の重複を回避できる
- 16bit全部1にするためには、色を-1にする。各アドレスに16bitあることは、アセンブラシミュレータを見るとよくわかる

## Ch05

- Keyboardはloadなどなく、Keyboardのアドレスを指定すれば、loadに関係なく押されているキーコードを出力する
- まずは使うべき下位の回路を列挙。また命令をデコードする（仕様をまとめる）
- 1つ前の命令の結果をDやAとして受け取る。2つ以上前の値は、loadされないときはレジスタが保持している
- DRegisterとARegisterが用意されている
- 回路内で完結する値は出力とはならないが、求めるべき値である
- 中心となるCPUが、コンピュータアーキテクチャ（ハードウェア階層）の核となる

## Ch06

- https://www.youtube.com/watch?v=C8LgvuEBraI Goを使ってみよう
- gotourをやる
- ポインタレシーバを使う2つの理由
  - ひとつは、メソッドがレシーバが指す先の変数を変更するため。main 関数で宣言した Vertex 変数を変更するためには、Scale メソッドはポインタレシーバにする必要がある→ポインタじゃないと変数を変更できない
  - ふたつに、メソッドの呼び出し毎に変数のコピーを避けるため
- よく、関数は error 変数を返します。そして、呼び出し元はエラーが nil かどうかを確認することでエラーをハンドル(取り扱い)する
- https://github.com/hirak/Assembler を読んで写経する
  - Parser
    - Scan
    - scanner.Text()
    - SplitN
    - text[0]
    - HasPrefix
  - SymbolTable
    - map[string]int
  - Assembler
    - for 条件 {}
    - strconv.Atoi()
    - \>>,<<,&：[バイナリ演算](http://golang.jp/tag/go%E8%A8%80%E8%AA%9E%E4%BB%95%E6%A7%98/page/2)
- ```go test .\projects\06\assembler ``` でテストできた
- https://godoc.org/github.com/gophersjp/go/src/cmd/go
- packageはmainでないと実行できない
- goファイルがあるフォルダで ``` go build ```


おまけ

やるべきこととできることがマッチすると大変勉強になる

## Ch07

- 概要：parserが、vmコマンドの意味を解釈して、asmコードを書くためのcodewriterに伝える
- 注意：まずはテスト/デバッグにある、XxxVme.tstを提供されているVMエミュレータで読み込みXxx.vmファイルを実行してみると、何をしているかわかる
- 全てのvmコマンドがスタック上で実行される

実装上のポイント

- iota https://qiita.com/curepine/items/2ae2f6504f0d28016411 enum
- import p "パス" pはエイリアス
- switch goでは選択されたcaseのみ実行する。その後のcaseは実行しない
- Parse()がhasMoreCommandsとadvanceの役になっている
- SP : Stack Pointer
- SPは、スタックのアドレスを保持する
- RAM[0] = sp は、スタックのアドレスを示す
- Push：SPを1増やす
- Stack[sp] = x; sp = sp + 1;
- Pop：SPを1減らす
- AM,AD,AMDはニーモニック。dest領域に変換されるもの
- Add命令
  - まず、アドレスとSPの値をデクリメント
  - Dに元のSP-1のMを保持
  - アドレスをデクリメント
  - Dと元のSP-2のMを足して、元のSP-2のMに設定する
- RAMの使用法
  - （使用法）：（アドレス）
  - スタティック変数：16-255
  - スタック：256-2047
  - ヒープ（オブジェクトと配列を格納する）：2048-16383
- メモリアクセスコマンドのために、セグメントがRAM上に直接マッピングされており、RAM上の場所を専用のレジスタ（R1-R15）とスタティック変数で保持している
- パス問題。Windowsに対応するため、util.goのPathInfo()について、"/" → separator := string(os.PathSeparator)に変更
  - https://golang.org/pkg/os/#PathSeparator
  - https://qiita.com/masakielastic/items/01a4fb691c572dd71a19