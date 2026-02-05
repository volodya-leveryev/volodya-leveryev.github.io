---
layout: python
title: Интеграция с библиотеками на C/C++
---

# Интеграция с библиотеками на C/C++

## Введение

Рекомендованные сторонние решения: https://docs.python.org/3/c-api/intro.html#c-api-tools

Интерпретатор предоставляет API для запуска Python-кода.

Интерпретатор позволяет вызывать код на С если он написан специальным образом.

Интерпретатор позволяет вызывать код на C с помощью библиотеки ctypes.

Соглашения для вызова кода (calling conventions) могут отличаться для разных языков, разных компиляторов, разных вычислительных архитектур, разных ОС и т.п. 
- [Calling convention](https://en.wikipedia.org/wiki/Calling_convention)
- [X86 calling conventions](https://en.wikipedia.org/wiki/X86_calling_conventions)
- [Name mangling](https://en.wikipedia.org/wiki/Name_mangling)

## Вызов подготовленного кода на C из Python

<pre><code class="language-cpp">
// модуль spam реализуется файлом spammodule.c
#define PY_SSIZE_T_CLEAN
#include &lt;Python.h&gt;

// функция system()
static PyObject* spam_system(PyObject *self, PyObject *args)
{
    const char *command;
    int sts;

    if (!PyArg_ParseTuple(args, "s", &command))
        return NULL;
    sts = system(command);
    return PyLong_FromLong(sts);
}
</code></pre>

на Python
<pre><code class="language-python">
import spam
status = spam.system("ls -l")
</code></pre>

## Вызов функций из динамических библиотек на C++ из Python

<pre><code class="language-cpp">
extern "C" long long mysum(long long n) {
    long long s = 0;
    #pragma omp parallel for reduction(+:s)
    for (long long i = 1; i <= n; i++) {
        s += 1;
    }
    return s;
}
</code></pre>

здесь `extern "C"` — отключает манглинг имен C++.

<pre><code class="language-python">
from threading import Thread
from ctypes import CDLL, c_longlong
from time import time

# Загружаем динамическую библиотеку
mylib = CDLL('./mylib.dll')


class MyThread(Thread):
   def __init__(self, n):
       super().__init__()
       self.n = n
       self.s = 0

   def run(self):
       self.s = mylib.mysum(self.n)


t1 = MyThread(c_longlong(4_000_000_000_000))
t2 = MyThread(c_longlong(4_000_000_000))


start = time()  # зафиксировали время старта

t1.start()  # асинхронный запуск
t2.start()  # асинхронный запуск

t1.join()  # ожидание завершения
t2.join()  # ожидание завершения

print(time() - start)  # зафиксировали время завершения
</code></pre>

## Вызов функций WinAPI из Python

<pre><code class="language-python">
import ctypes
from ctypes import wintypes
from pprint import pprint

user32 = ctypes.windll.user32


def get_open_windows(parent_handle=None):
   windows = []


   @ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
   def callback(handle, _param):
       if not user32.IsWindowVisible(handle):
           return True
       length = user32.GetWindowTextLengthW(handle)
       if length > 0:
           buffer = ctypes.create_unicode_buffer(length + 1)
           user32.GetWindowTextW(handle, buffer, length + 1)
           # process_id = get_window_process_id(handle)
           child_windows = get_open_windows(handle)
           windows.append((buffer.value, child_windows))
       return True


   if parent_handle:
       user32.EnumChildWindows(parent_handle, callback, 0)
   else:
       user32.EnumWindows(callback, 0)
   return windows


pprint(get_open_windows())
</code></pre>
