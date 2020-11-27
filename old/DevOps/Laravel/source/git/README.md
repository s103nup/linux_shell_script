## 專案用途
<專案用途說明>

## 目錄
* [環境需求](#環境需求)
* [相依元件](#相依元件)
* [建置方式](#建置方式)
* [文件](#文件)
* [目錄結構](#目錄結構)
* [注意事項](#注意事項)

## 環境需求
- PHP-FPM <php-fpm 版號>
- Nginx <nginx 版號>
- MySQL <mysql 版號>
- Laravel <Laravel 版號>

## 相依元件
 - <相依元件>

## 建置方式
- Local(Development)
```bash
<建置方式>
```

- Beta(Testing)
```bash
<建置方式>
```

- Stage(Staging)
```bash
<建置方式>
```

- Production
```bash
<建置方式>
```

## 文件
請參考<部門資料夾>\文件\<專案名稱>\

## 單元測試
```bash
cd <專案目錄>
./vendor/bin/phpunit --testdox --testsuit=Unit
```

## 功能測試
```bash
cd <專案目錄>
./vendor/bin/phpunit --testdox --testsuit=Feature
```

## E2E 測試
```bash
cd <專案目錄>
php artisan dusk --testdox
```

## 目錄結構
請參考 Laravel 目錄結構，自訂目錄結構如下:

    ├── app/
    │   └── Models/       # Model, 處理資料表關聯與定義
    │   └── Repositories/ # Repository, 處理資料庫邏輯
    │   └── Services/     # Service, 處理商業邏輯
    ├── scripts/          # 專案相關腳本
    │   └── devops/
    │       └── beta/     # Beta 自動化部署腳本
    │       └── stage/    # Stage 自動化部署腳本
    │       └── prod/     # Prodction 自動化部署腳本
    ├── tests/
    │   └── Broswer/      # E2E 測試項目
    │   └── Feature/      # 功能測試項目
    │   └── Unit/         # 單元測試項目
    └── README.md         # 說明
