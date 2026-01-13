# 

# Scheduler Project

## Requirements

- Ruby 3.3+
- PostgreSQL 15+
- Bundler

---

## Setup

1. **リポジトリをクローン**
    
    `git clone <リポジトリURL>` してプロジェクトディレクトリに移動
    
2. **Gem をインストール**
    
    `bundle install` を実行
    
3. **環境変数の設定**
    - `cp .env.sample .env` を実行
    - `.env` の `DB_USER_NAME=` にユーザ名を、`DB_PASSWORD=` にパスワードを記入
        
        ```
        DB_USER_NAME=hoge
        DB_PASSEORD=9999
        ```
        
4. **データベースの作成とマイグレーション**
    
    `rails db:prepare` を実行
    
5. **サーバー起動**
    
    `rails server` を実行して `http://localhost:3000` にアクセス