---
layout: default
title: Powershell
---

# Powershell

## Как работать?

- Оболочка
- Среда для написания сценариев ISE

## Помощь

Командлет --- это команды в PowerShell:

- `Get-Help`
- `Get-Help -Full`
- `Get-Help -Online`
- `Get-Help -Detail`
- `Get-Help -Examples`

Алиасы --- это псевдонимы для командлетов:

- `Get-Command` --- перечень командлетов, функций и алиасов
- `Get-Command -CommandType Alias`
- `Set-Alias` --- создать алиас

Элементы языка --- регистронезависимые.

## Работа с файлами

- `Get-ChildItem`, `dir`, `ls`, `gci` --- перечень файлов и каталогов
- `Get-Location`, `pwd`, `gl` --- получить каталог
- `Set-Location`, `cd`, `chdir`, `sl` --- сменить каталог
- `Copy-Item`, `copy`, `cp`, `cpi` --- копирование файлов / каталогов
- `Move-Item`, `mi`, `move`, `mv` --- перемещение файлов / каталогов
- `Remove-Item`, `del`, `erase`, `rd`, `ri`, `rm`, `rmdir` --- удаление файлов / каталогов
- `Rename-Item`, `ri`, `ren` --- переименование файлов / каталогов
- `New-Item`, `ni` --- создание файлов / каталогов
- `Get-Content` --- печать содержимого текстового файла
- `Add-Content` --- добавить в текстового файл содержимое
- `Set-Content` --- заменить в текстового файл содержимое

1. Создать каталог (`New-Item`)
2. Войти в каталог
3. Создать пустой файл
4. Переименовать файл
5. Скопируйте файл
6. Удалите все созданные файлы и каталоги

## Скрипты

Скрипты имеют расширение ".PS1"

Если политика выполнения скриптов:

- `Restricted`, cкрипты не выполняются
- `AllSigned`, все скрипты должны иметь цифровую подпись
- `RemoteSigned`, чужие скрипты должны иметь цифровую подпись
- `Unresticted`, все скрипты выполняются

`Get-ExecutionPolicy` --- получение политики

`Set-ExecutionPolicy` --- изменение политики, нужны права администратора (имикиц428)

`Get-Help about_Execution_Policies` --- помощь по политике исполнения

## Работа с процессами

- `Get-Process` --- информация о процессах
- `Stop-Process` --- остановка процесса
- `Get-Service` --- информация о службах
- `New-Service` --- создать новую службу
- `Restart-Service` --- перезапустить службу
- `Resume-Service` --- возобновить работу службы
- `Set-Service` --- изменить службу
- `Start-Service` --- запустить службу
- `Stop-Service` --- остановить службу
- `Suspend-Service` --- приостановить службу

----------------------------------------
Установка и удаление компонентов Windows
----------------------------------------

- `Get-WindowsFeature` --- перечень доступных компонент (ролей) Windows
- `Install-WindowsFeature` --- установить компоненту (роль) Windows
- `Uninstall-WindowsFeature` --- удалить компоненту (роль) Windows

---------
Конвейеры
---------

PowerShell тесно интегрирован с .NET Framework

PowerShell в отличие от Cmd, Bash и других оболочек оперирует объектами

`Select-Object` --- выбор свойств объектов

`Where-Object`, `?`, `where` --- фильтрация объектов по условию

`Export-CSV` --- вывод в таблицу CSV

`ConvertTo-HTML` --- конвертировать результат в HTML

Примеры:

```powershell
  Get-Process | Where-Object {$_.ProcessName -match '^p.*'}
```

```powershell
  Get-Process | where {$_.ProcessName -like '*power*'} | ConvertTo-Html
```

```powershell
  Get-Process | ? {$_.ProcessName -eq 'iexplore'} | Stop-Process
```

## Синтаксические конструкции

Однострочный комментарий

```powershell
  <#
    Многострочный комментарий
  #>
```

Цикл `For`:

```powershell
  For ($i = 0; $i -lt 10; $i++)
  {
      If ($i % 2 -eq 0)
      {
          Write-Output "Чет: $i"
      }
      ElseIf ($i % 3 -eq 0)
      {
          Write-Output "Делится на 3: $i"
      }
      Else
      {
          Write-Output "Что-то другое: $i"
      }
      $i++
  }
```

Цикл `While`:

```powershell
  $i = 0
  While ($i -lt 10)
  {
      If ($i % 2 -eq 0)
      {
          Write-Output "Чет: $i"
      }
      ElseIf ($i % 3 -eq 0)
      {
          Write-Output "Делится на 3: $i"
      }
      Else
      {
          Write-Output "Что-то другое: $i"
      }
      $i++
  }
```

Цикл `ForEach`:

```powershell
  function test($i)
  {
      return "Hello $i"
  }
  foreach ($file in Get-ChildItem)
  {
      test($file.Name)
  }
```

Работа с функциями:

```powershell
  function fact($i)
  {
      if ($i -eq 1)
      {
          return 1
      }
      else
      {
          $a = fact($i-1)
          return $i * $a
      }
  }
  fact(20)
```

Ветвление:

```powershell
  $dow = "Friday"
  switch ($dow) {
    "Friday" {
      "Day is Friday"
    }
    "Tuesday" {
      "Day is Tuesday"
    }
    "Friday" {
      "Day is Friday"
    }
  }
```

Циклы с постусловием:

```powershell
  do {
    statement_list
  } while (conditional_expression)
```

```powershell
  do {
    statement_list
  } until (conditional_expression)
```
