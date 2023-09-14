---
layout: default
title: Введение
---

# Введение

Python — интерпретируемый ЯП (но с компиляцией в байт-код)
Python — динамически типизируемый ЯП (но с опциональными аннотациями типов)
Python — объектно-ориентированный ЯП
Python поддерживает интроспекцию (help, dir, type, vars)

Реализации Python:
- CPython (pip)
- MicroPython
- PyPy
- IronPython
- Stackless Python
- Jython
- Cython

Дистрибутивы:
- Anaconda (conda)
- Enthought Canopy
- python(x,y) - не развивается

Оболочки:
- встроенная
- bPython
- iPython

Куда можно установить пакеты в Python:
- системные
- пакеты пользователя
- виртуальное окружение - каталог для хранения пакетов, привязанных к опр. проекту
  - pipenv
  - poetry
- можно указать вручную (sys.path, PYTHONPATH)

IDE, Integrated Development Environment:
- VS Code / Vscodium (нужен сервер LSP, Language Service Protocol)
- PyCharm
- IDLE (примитивный)
- Wing IDE
- Komodo IDE
- Netbeans
- Eclipse (Pydev)
- Vim / Neovim

Линтеры (статический анализатор кода) - поиск ошибок в коде без его запуска:
- flake8
- pylint
- bandit
- mypy

Профилировщики - анализ производительности кода
- встроенные в стандартную библиотеку
- другие

Фреймворки тестирования ПО (для unit-тестирования)
- unittest
- pytest
- nose
Во время модульного тестирования можно измерить тестовое покрытие
