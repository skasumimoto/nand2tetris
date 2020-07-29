## Ch01 ブール論理

- f内のfは×
- sel[2] = 10 → sel[0] = 0
- セレクタ：1要素ずつ分岐する。 → k = log2 n
- 変数名にそれまでの評価分を与えるとわかりやすい。＠DMux8Way,Mux4Way16
- 評価の順番を考える。＠DMux8Way,Mux4Way16
- headerでlengthを定義していれば、配列は変数名で参照できる（当たり前）。

## Ch02 ブール算術

- 全加算：和の半加算を2回→sum、各半加算のcarryのOr→carry
- 分岐はMuxで表せる
- 反転はただのNot。でも反転するかどうかは入力で分岐してる。
- x[i..j]の指定のため、A.5.3のバスを用いる。接続ピンの任意の幅を接続に指定できる。
- 定数であるtrue,falseがバスで使えることも、A.5.3に書いてある

## Ch03 順序回路

- まずは図をそのまま書き起こす
- フィードバックループ：出力をフィードバックとしても流す
- DMuxはinを伝えるかどうか選択に使える
- sel = 101110 → sel[0..2] = 110
- RAM8をベースとしたメモリの再帰構造
- load（書き込み）とフィードバックにより、out(t) = inまたはout(t - 1)の関係が成り立つ
- inまたはout(t - 1)は、DFFが時間遅延という性質を持つことでフィードバックできる

## Ch04 機械語

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

## Ch05 コンピュータアーキテクチャ

- Keyboardはloadなどなく、Keyboardのアドレスを指定すれば、loadに関係なく押されているキーコードを出力する
- まずは使うべき下位の回路を列挙。また命令をデコードする（仕様をまとめる）
- 1つ前の命令の結果をDやAとして受け取る。2つ以上前の値は、loadされないときはレジスタが保持している
- DRegisterとARegisterが用意されている
- 回路内で完結する値は出力とはならないが、求めるべき値である
- 中心となるCPUが、コンピュータアーキテクチャ（ハードウェア階層）の核となる

## Ch06 アセンブラ

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
- ```go test .\projects\06\assembler ``` でテストできる
- https://godoc.org/github.com/gophersjp/go/src/cmd/go
- packageはmainでないと実行できない
- goファイルがあるフォルダで ``` go build ```

## Ch07-Ch08 バーチャルマシン

- 概要：parserが、vmコマンドの意味を解釈して、asmコードを書くためのcodewriterに伝える
- 注意：まずはテスト/デバッグにあるXxxVme.tstを提供されているVMエミュレータで読み込み、Xxx.vmファイルを実行すると、何をしているかわかる
- 全てのvmコマンドがスタック上で実行される

実装上のポイント

- iota https://qiita.com/curepine/items/2ae2f6504f0d28016411 enum
- import p "パス" ： pはエイリアス
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
- RAMの使用法 （使用法）：（アドレス）
  - スタティック変数：16-255
  - スタック：256-2047
  - ヒープ（オブジェクトと配列を格納する）：2048-16383
- メモリアクセスコマンドのために、セグメントがRAM上に直接マッピングされており、RAM上の場所を専用のレジスタ（R1-R15）とスタティック変数で保持している
- パス問題。Windowsに対応するため、util.goのPathInfo()について、"/" → separator := string(os.PathSeparator)に変更
  - https://golang.org/pkg/os/#PathSeparator
  - https://qiita.com/masakielastic/items/01a4fb691c572dd71a19
- 管理者でvm_translator.exeを実行しないと、ファイルが作成できなかったり
- functionName$label : グローバルでユニークなf$bというシンボルを生成する
- 初期化処理でSPのMに256（スタックのアドレス）を設定する
- ROMのアドレスが0から始まるコードセグメント：ブートストラップコード ← コンピュータがブートアップしたときに最初に実行されるコード
- Sys.initがメインプログラムのメイン関数を呼び出す
- Sys.initはvmファイルに書かれている
- WriteComparatorは、ラベルを作って、条件を満たす/満たさない場合それぞれの処理を記述している
- Callでリターンアドレス以下に一通り保持し、Returnで戻す
- strconvでstringとintを相互変換

## Ch10-Ch11 コンパイラ

- コンパイラ ： .jackからTokenizerを生成 → .vmファイルを作成し、書き込みの準備 → CompilationEngineで、Tokenizerを出力ファイルへコンパイル。
  - Tokenizer ： プログラム構文解析の最初の一歩として、**文字のグループをトークンにまとめる**。**字句解析**と呼ぶタスク。
    - token : 終端要素。文字列と種類を保持
      - keywordとsymbolを定数で保持
    - [Creating a slice with make](https://go-tour-jp.appspot.com/moretypes/13)
    - [rune is an alias for int32 and is equivalent to int32 in all ways. It is used, by convention, to distinguish character values from integer values.](https://golang.org/src/builtin/builtin.go?h=rune#L92)
    - varidatorsがidentifierを識別する
      - [range](https://go-tour-jp.appspot.com/moretypes/16)
    - 1文字ずつ保持していきトークンになったかどうか判定する
    - newCharはトークンに追加されていない次の文字。それまでがキーワードでも、次に別のidentifierが来ればキーワードではなくなるためバリデーションを実行する
    - Tokensにインデックスを持たせて、Nextでインデックスをインクリしている
  - CompilationEngine ： Tokenizerから入力を受取、構文解析した構造を出力ファイル/ストリームへ出力する。
    - **プログラム構造ごとにコンパイル**を実行するルーチンを実装する。
      - compileClass(完全に展開したものではありません)
        - compileClassVarDec ： クラス変数がある分だけ再帰的に呼び出す
        - compileClassSubroutineDec ： } が来るまで再帰的に呼び出す
          - compileParameterList
          - compileSubroutineBody
            - compileVarDec
            - compileStatements
              - compileLetStatement
                - push segment index : segment[index]をスタックの上にプッシュする
                - pop segment index : スタックの一番上のデータをポップし、それをsegment[index]に格納する
              - compileIfStatement
              - compileWhileStatement
                - ラベルの生成
                - スタック ： ...,x,y,not(←SP)のとき、Not yを戻り値とする → 条件(y)を満たさないとき、whileを抜けることを表している
                - compileExpression
                  - compileTerm
                    - トークンのタイプごとにvmコマンドを生成する
              - compileDoStatement
                - compileSubroutineCall
              - compileReturnStatement
      - symboltable : シンボルテーブルを管理する
        - クラステーブルとサブルーチンテーブルに分けて変数を保持する
    - [defer](https://go-tour-jp.appspot.com/flowcontrol/12)
    - [...](https://qiita.com/hnakamur/items/c3560a4b780487ef6065)
    - Ruleは右のように定義されている。type Rule func(s string) bool
      - Identity(a string)では、Ruleの生成時に渡したaと、Ruleの呼び出し時に渡すbを比較する
- main
  - [Glob : パターンマッチ](https://golang.org/pkg/path/filepath/#Glob)

## Ch12 オペレーティングシステム

- Math
  - bit(x,j)のために、スタティック変数twoToTheをinitで生成する
  - 「& |」 booleanのAndとOr演算子（ビット単位）
  - 「- ~」 符号反転/boolean否定
  - 「>=」などは使えない
  - sqrt
    - [二分探索](https://qiita.com/sh0623k/items/f5028e9da52d90bfde1b#8%E5%A4%A7%E8%A6%8F%E6%A8%A1%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E6%A4%9C%E7%B4%A2)
      - start,endを操作する
      - 同じデータに何度も検索を行う場合や、既に整列済みのデータに対してのみ有効
      - sqrtではyがstartになっている
      - (temp2 > 0)により、16bitで表す正の整数を超えた場合を回避する
- String
  - currentLen, maxLenを保持する
  - int2String
    - 再帰的に文字列を設定する
- Array
  - Memoryのアロケーションを使用
- Output ： カーソル操作と文字の出力が基本機能となる
  - 文字は配列として表現。配列は11個の要素からなり、各要素は文字画像の各行のピクセルに対応するバイナリ数 
  - 横が8bitであり、カーソルXの偶奇の情報がアドレスでは落ちるため、偶奇の情報を変数に保持し、16bitの内の左右どちらに描画するか判断している
- Screen
  - 直線描画、円描画は背景節の通りに実装する
- keyboard
  - キーボード用メモリマップのRAMアドレスを使用する
  - whileを抜けるまではキーが押されている（変わっていない判定）
  - Stringを使用して判定する
  - 行を読むときは文字を読む処理を繰り返す
- Memory
  - peek ： Memory[address]を返す
  - poke :　Memory[address]に値を設定する
  - alloc
    - 利用可能なメモリセグメントを連結リスト：freeListで管理
    - 初めはfreeList内に分割されたブロックはなく、アロケーションで、要求したサイズに応じてブロックを作成する
    - foundBlock[LENGTH] > (size + 3)を満たさないとき、次のブロックのNEXTを指定しないことでfreeListから破棄している。残ったブロックのサイズが十分な時は、残ったブロックのNEXTに元々のNEXTを格納することで、残ったブロックと元々のNEXTブロックをつないでいる
    - block[-1]に、破棄のためのブロックのサイズを保持する
    - bestfitPrevは、連結リストにある分だけブロックを参照して、最適なブロックを見つける処理
  - deAlloc
    - findPrevFreeで1つ前のブロックを探す
    - 前のブロックがなければ、セグメントをそのままfreeListに連結する
    - 前のブロックのアドレスと前のブロックの長さの和が対象のセグメントのアドレスの場合は、前のブロックと結合する
    - そうでない場合は、前のブロックと連結する
    - 最終的にセグメントのアドレスとセグメントの長さの和が次のブロックのアドレスだった場合は、次のブロックと結合する
- Sys
  - init ： 他のOSクラスのinit()を呼び出す → Main.main()を呼び出す → 無限ループ(halt())に入る
  - halt ： 無限ループ
  - wait ： nミリ秒間実行するループ関数を使う。CPUによって必要なループ回数は変化するため、特定のコンピュータで回数を計測する
  - error ： エラーコードをスクリーンに表示し、プログラムの実行を終了（無限ループ）する