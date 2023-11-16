# Работа с GitHub Actions

1. Создать репозиторий в GitHub с названием `*.github.io`
2. Склонировать репозиторий на локальный компьютер
3. Установить [Hugo](https://gohugo.io)
4. Создать скелет нового сайта: `hugo new site --force .`
5. Добавить тему оформления:

   ```
   git submodule add --depth 1 https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
   ```

6. Задать тему в конфигурационной файл `hugo.toml` добавить `theme = 'ananke'`
7. Создать страницу `hugo new content posts/my-first-post.md`
8. Проверить работу сайта локально `hugo server`
9. Добавить файл описания workflow для GitHub Actions `.github/workflows/deploy.yml`:

   ```yaml
   on: push
   jobs:
     deploy:
       runs-on: ubuntu-latest
       steps:
         - name: checkout
           uses: action/checkout@v4
           with:
             submodules: 'true'

         - name: hugo installation
           run:
             sudo apt-get update
             && sudo apt-get install -y hugo
             && sudo hugo

         - name: deploy
           uses: JamesIves/github-pages-deploy-action@v4
           with:
             folder: public
   ```

   Документация: https://github.com/marketplace/actions/deploy-to-github-pages
10. Переименовать файл `hugo.toml` в `config.toml`
11. Создать `.gitignore` файл, чтобы не пушить файлы из папки `public`
12. Закоммитить и запушить в GitHub
13. Проследить работу GitHub Actions
14. Перейти в настройки репозитория и в разделе GitHub Pages указать публикацию из ветки `gh-pages`
