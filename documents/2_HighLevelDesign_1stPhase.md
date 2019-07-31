# AMA High Level Desgin

## View
* ホーム（root）
    * ログイン前
      * ログインフォーム
    * ログイン後
      * →ユーザーページに飛ぶ
* ユーザーページ
  * ログイン前／自分以外
    * その人へのメッセージフォーム
  * ログイン後 && 自分
    * メッセージ一覧
* 設定画面
  * ※1st Phaseでは中身なし

## Model
* User
* AnonymousMessage

## Controller
* Application
* Users
* Sessions
* StaticPages
* AnonymousMessages

## Mailer
* UserMailer

## DataBase
### Users table
* ID
* email
* created_at
* updated_at
* password_digest
* remember_digest

### Anonymous Messages table
* ID
* User id
* content
* created_at
* updated_at
* replayed
