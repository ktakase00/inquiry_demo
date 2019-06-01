# inquiry

## 実習内容

* サンプルプログラム `inquiry` において、問い合わせ登録時に「受付コード」を取得し、テーブルに保存するようにソースコードを変更してください。
* 自分が変更したソースコードにおいて、オブジェクト指向を取り入れたポイントを発表してください。

## サンプルプログラムについて

### 概要

サンプルプログラム `inquiry` は、お問い合わせを受け付け、その内容をデータベースに保存するWebアプリケーションです。

* お問い合わせの一覧、詳細、新規登録の3つの画面で構成されています。
* 新規登録画面で入力できる項目は、以下の2つです。
  * 問い合わせコード
  * 問い合わせ内容
* 問い合わせコードは以下の3種類から選択します。
  * 営業への質問(01)
  * ヘルプデスクへの質問(02)
  * 技術フォーラムへの質問(03)

### DB

お問い合わせの内容は `inquiries` テーブルに保存されます。テーブルは以下のカラムで構成されています。

|物理名|論理名|型|NULL可否|デフォルト値|用途|
|---|---|---|---|---|---|
|id|ID|BIGINT|否|0|主キー|
|inquiry_at|問い合わせ日時|TIMESTAMPTZ|否|(なし)|問い合わせを受け付けた日時|
|inquiry_cd|問い合わせコード|TEXT|否|''|問い合わせの種別を表すコード、01/02/03のいずれか|
|inquiry_content|問い合わせ内容|TEXT|否|''|問い合わせ内容の文章|
|accept_cd|受付コード|TEXT|否|''|外部サービスから返却された識別コード|
|error_json|エラーJSON|TEXT|否|{}|外部サービス登録時に発生したエラーの内容|
|created_at|登録日時|TIMESTAMPTZ|否|(なし)|レコードの新規登録日時|
|updated_at|更新日時|TIMESTAMPTZ|否|(なし)|レコードの更新日時|

### 要件

* 問い合わせを受け付けた時、その内容を外部サービスに連携するものとします。
* 連携するサービスは3つあり、問い合わせコードごとに連携先が異なるとします。
* 各外部サービスには問い合わせ内容を送信すると受付コードが返却されるAPIがあるとします。
* 問い合わせコードごとの連携先外部サービスを下表の通りとします。
* 指定された問い合わせコードに従って、外部サービスから受付コードを取得し、 `inquiries` テーブルに保存してください。

|問い合わせコード(表示名)|問い合わせコード(値)|連携先サービス|APIクラス|
|---|---|---|---|
|営業への質問|01|営業支援システム|ExService::Sales|
|ヘルプデスクへの質問|02|ヘルプデスクツール|ExService::HelpDesk|
|技術フォーラムへの質問|03|技術フォーラム|ExService::TechForum|

サンプルプログラムは初期状態では受付コードが空文字列で登録されるようになっています。要件にあわせてプログラムを修正してください。

### 補足1：外部サービスAPIについて

外部サービスAPIは、それぞれクラスが用意されています。実際には通信などは行わず、受付コードの採番のみを行うダミーの処理内容になっています。これらのクラスを使用して、受付コードを生成してください。

各外部サービスAPIは、実行方法と返却値の形が異なります。それぞれの実行方法と返却値の例を以下に示します。

#### ExService::Sales

**実行方法**

```ruby
ex_service = ExService::Sales.new
res = ex_service.register('教えてください。')
```

**返却値の例**

```ruby
{
  code: 's001'  # ←これが受付コード
}
```

#### ExService::HelpDesk

**実行方法**

```ruby
ex_service = ExService::HelpDesk.new
res = ex_service.create('教えてください。')
```

**返却値の例**

```ruby
{
  code: 0,  # ←成功かエラーかを表す値、0が成功、1がエラー
  body: {
    ident: 'h001'  # ←これが受付コード
  }
}
```

#### ExService::TechForum

**実行方法**

```ruby
res = ExService::TechForum.add_inquiry('教えてください。')
```

**返却値の例**

```ruby
{
  code: 't001'  # ←これが受付コード
}
```

### 補足2：プロジェクトの設定について

* libディレクトリの下は、autoloadの対象になっています。
* Inquiriesコントローラのcreateアクションには、 `before_action` が登録されてます。扱いにくい場合は解除してください。
* 問い合わせ日時は、 `Inquiry` モデルの `before_create` コールバックにより設定されるようになっています。コントローラ側から与える必要はありません。

### 補足3：外部サービスAPIのエラーについて

* 実習時間の都合により、外部サービスAPIがエラーを発生させた場合については考慮しなくて構いません。外部サービスAPIは必ず成功するものとしてください。

## 開発環境の構築

### Gitリポジトリのクローン

```
git clone https://github.com/ktakase00/inquiry_demo.git
```

### dbコンテナ起動

```
docker-compose up -d db
```

### webコンテナ用イメージ作成

```
docker pull ktakase00/rubypg-learn:uv-201905
```

### webコンテナ起動

```
./docker_run_web.sh
```

→webコンテナ内でbashが実行された状態になる。

### webコンテナ内プロジェクトルートパス設定

webコンテナ内で設定する。

```
export WEB_ROOT=~/repo/inquiry
```

### Rails実行環境初期化

webコンテナ内で実行する。

```
cd $WEB_ROOT
./setup.sh
```

→以下の処理が実行される。

* 開発用master.keyのコピー
* bundle install
* yarn install
* db:migrate
* db:seed

開発環境を停止する場合は、以下の手順を実施する。

1. webコンテナ内のbashを終了する。
2. 以下のコマンドでdbコンテナを停止する。

```
docker-compose down
```

## 開発環境の起動

* 「開発環境の構築」の手順が完了しているとする。
* 「開発環境の構築」の手順の実施後、開発環境を停止していない場合は、「rails起動」以降の手順のみ実施する。

### dbコンテナ起動

```
docker-compose up -d db
```

### webコンテナ起動

```
./docker_run_web.sh
```

→webコンテナ内でbashが実行された状態になる。

### webコンテナ内プロジェクトルートパス設定

```
export WEB_ROOT=~/repo/inquiry
```

### データベース初期化

webコンテナ内で実行する。

```
cd $WEB_ROOT
bundle exec rails db:migrate
bundle exec rails db:seed
```

### rails起動

webコンテナ内で実行する。

```
cd $WEB_ROOT
bundle exec rails server -b 0.0.0.0
```

### webアクセス

ホストコンピュータのWebブラウザでアクセスする。

```
http://localhost:3000/inquiries
```

## 開発環境の停止

### rails停止

1. webコンテナ内でrailsを停止する。
2. webコンテナのbashを終了する。

→webコンテナが破棄される。

### dbコンテナ停止

```
docker-compose down
```

→dbコンテナが破棄される。
