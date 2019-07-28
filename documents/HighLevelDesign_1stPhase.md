# AMA High Level Desgin

## View
* ホーム
    * ログイン後
        * メッセージ一覧
            * 返信してないやつ
            * 返信してるやつ
    * ログイン前
        * アプリの説明
        * Sing up
        * ログインページへのリンク
* ログインページ
* その人へのメッセージ送信画面
* 設定画面
    * パスワード
    * メール

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
* favorite