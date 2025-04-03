# GitHub Pages
## Теоретическая часть

**Цель работы**: создать статический сайт с помощью [GitHub Pages](https://pages.github.com/) и автоматизировать генерацию контента с помощью [GitHub Actions](https://github.com/features/actions).

[Генераторы статических сайтов (SSG)](https://liquidhub.ru/blogs/blog/generatsiya-staticheskikh-saytov) – это инструменты, которые создают веб-страницы заранее, формируя статические HTML, CSS и JavaScript файлы. В отличие от динамических сайтов, они не требуют серверной обработки при каждом запросе, что делает их быстрыми, безопасными и удобными для масштабирования. Популярные SSG, такие как [Jekyll](https://jekyllrb.com/), [Hugo](https://gohugo.io/) и [Next.js](https://nextjs.org/) в режиме статической генерации, часто используются для блогов, документации и корпоративных сайтов. Они позволяют разработчикам использовать шаблоны, автоматизировать создание контента и легко развертывать сайты на хостингах вроде [GitHub Pages](https://pages.github.com/) или [Netlify](https://www.netlify.com/). Благодаря этим преимуществам генераторы статических сайтов становятся отличным выбором для проектов, где важны скорость и простота обслуживания.

[GitHub Pages](https://pages.github.com/) — это бесплатный хостинг для статических сайтов, предоставляемый GitHub. Он позволяет размещать веб-страницы прямо из репозитория, что делает его удобным для документации, блогов и личных проектов. Доменное имя для сайта аккаунта формируется по шаблону `<username>.github.io`, где `<username>` — это имя пользователя или организации на GitHub. Для сайтов проектов используется поддомен `<username>.github.io/<repository>`, где `<repository>` — это название репозитория, содержащего файлы сайта. Также можно привязать собственный домен, добавив файл `CNAME` в корневую директорию репозитория и настроив DNS-записи.

[GitHub Actions](https://github.com/features/actions) — это встроенный инструмент автоматизации CI/CD в GitHub, который позволяет настраивать и выполнять рабочие процессы (workflows) для тестирования, сборки и развертывания кода. Он основан на файлах YAML, где можно описать триггеры (например, коммиты, пул-реквесты, релизы) и последовательность задач. Для упрощения настройки GitHub предоставляет [GitHub Marketplace](https://github.com/marketplace), где можно найти готовые экшены (actions), созданные сообществом и компаниями. Эти экшены позволяют, например, автоматически деплоить сайт, запускать тесты или анализировать код без необходимости писать скрипты с нуля. Благодаря глубокой интеграции с репозиториями и гибкости GitHub Actions значительно упрощает процесс DevOps.

## Практическая часть

1. Откройте [GitHub](https://github.com), авторизуйтесь, создайте новый репозиторий.

2. Проверьте параметры аутентификации Git (в параметрах Windows откройте 
Диспетчер учетных данных и уберите других пользователей GitHub).

3. Склонируйте репозиторий на локальный компьютер и настройте имя ветки:
    ```cmd
    git clone <URL репозитория> <Каталог проекта>
    cd <Каталог проекта>
    git branch -M main
    ```

4. Если за данным компьютером работают другие студенты, то укажите параметры пользователя Git:
    ```cmd
    git config --local user.name "<Имя разработчика>"
    git config --local user.email "<Email разработчика>"
    git config --list --local
    ```

5. Скачайте подходящий для вашей ОС [расширенный (extended) релиз Hugo](https://github.com/gohugoio/hugo/releases/) и распакуйте исполняемый файл (`hugo.exe`) в папку проекта. Добавьте его в `.gitignore`.

6. Создайте минимальный статический сайт:
    ```cmd
    hugo new site . --force
    ```

7. Добавьте тему оформления:
    ```
    git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
    echo "theme = 'ananke'" >> hugo.toml
    ```

8. Добавьте три новые страницы о книгах или фильмах, добавьте текст и уберите признак черновика (draft) из front matter:
    ```cmd
    hugo new content posts/my-first-post.md
    hugo new content posts/my-second-post.md
    hugo new content posts/my-third-post.md
    ```

9. Проверьте работу на локальном компьютере в браузере:
    ```cmd
    hugo server --buildDrafts
    ```

10. Откройте настройки репозитория, откройте раздел с настройками `Pages`, включите сборку и публикацию с помощью GitHub Actions.

11. Создайте описание рабочего процесса для GitHub Actions в файле `.github/workflows/pages.yml`.

12. Сделайте коммит и отправить код в центральный репозиторий:
    ```cmd
    git add .
    git commit -m "Начальный коммит"
    git push -u origin main
    ```

13. Откройте URL из настроек репозитория, убедитесь что сайт работает.

14. Внесите изменения в посты через веб-интерфейс GitHub и проверьте работу CI/CD.

## Приложения
**./github/workflows/pages.yml:**
```yaml
name: Deploy Hugo site to Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: <Текущая версия Hugo>
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: true
          fetch-depth: 0

      - name: Install Hugo
        run: |
          wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb
          sudo dpkg -i ${{ runner.temp }}/hugo.deb

      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5

      - name: Build
        run: hugo --minify --baseURL "${{ steps.pages.outputs.base_url }}/"

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## Ссылки
- [https://docs.github.com/pages](https://docs.github.com/pages)
- [https://docs.github.com/actions](https://docs.github.com/actions)
- [https://gohugo.io/getting-started/quick-start/](https://gohugo.io/getting-started/quick-start/)
- [https://github.com/actions/configure-pages](https://github.com/actions/configure-pages)
- [https://github.com/actions/upload-pages-artifact](https://github.com/actions/upload-pages-artifact)
- [https://github.com/actions/deploy-pages](https://github.com/actions/deploy-pages)
