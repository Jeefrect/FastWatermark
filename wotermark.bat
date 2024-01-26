@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Получение пути к текущей папке bat-файла
set "script_path=%~dp0"

rem Переход в текущую папку bat-файла
cd "%script_path%"

rem Путь к ffmpeg в текущей папке
set "ffmpeg_path=ffmpeg.exe"

rem Путь к вотермарке (изображение в формате PNG)
set "watermark_path=white_op.png"

rem Папка для выходных файлов
set "output_folder=output"

rem Создание папки для выходных файлов, если её нет
if not exist "%output_folder%" mkdir "%output_folder%"

rem Проверка наличия входного видео
if "%~1"=="" (
    echo Перетащи видеофайл на этот bat-файл, дебил.
    pause
    exit /b
)

rem Имя входного файла
set "input_file=%~1"

rem Имя выходного файла (с таким же именем, но в папке output)
set "output_file=%output_folder%\%~n1.mp4"

rem Команда ffmpeg для наложения вотермарки (что хочешь можешь написать, документации полно в инете)
set "ffmpeg_command=!ffmpeg_path! -i "!input_file!" -i "!watermark_path!" -filter_complex overlay=W-w-10:H-h-10 "!output_file!"

echo Выполняется обработка...
call !ffmpeg_command!

echo Видео с вотермаркой создано: "!output_file!"

pause
