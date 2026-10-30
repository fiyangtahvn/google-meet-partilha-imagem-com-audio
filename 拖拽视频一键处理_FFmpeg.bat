@echo off
chcp 936 >nul
title FFmpeg 视频处理工具
if "%~1"=="" (
    echo [使用说明] 请将录制好的视频文件拖拽到本批处理图标上！
    echo.
    pause
    exit /b
)

set INPUT=%~1
set OUT_FIXED=%~dpn1_fixed.mp4
set OUT_BOOST=%~dpn1_人声增强.mp4

echo ========================================================
echo  已加载视频: "%~nx1"
echo ========================================================
echo  [1] 极速转封装为标准 MP4 (原汁原味，1秒完成)
echo  [2] 智能增强人声与响度均衡 (放大微弱麦克风，平衡人声)
echo ========================================================
set opt=1
set /p opt="请选择模式 [回车默认 1，输入 2 增强人声]: "

if "%opt%"=="2" (
    echo.
    echo 正在进行人声音量动态增强与响度平衡处理...
    ffmpeg -hide_banner -stats -i "%INPUT%" -c:v copy -af "speechnorm=e=4:r=0.0001:l=1,volume=1.5" -c:a aac -b:a 192k "%OUT_BOOST%" -y
    echo.
    echo 处理完成！已生成: "%OUT_BOOST%"
) else (
    echo.
    echo 正在进行极速标准 MP4 封装...
    ffmpeg -hide_banner -loglevel warning -stats -i "%INPUT%" -c:v copy -c:a aac -b:a 192k "%OUT_FIXED%" -y
    echo.
    echo 转换完成！已生成: "%OUT_FIXED%"
)

echo.
echo 任务结束。按任意键退出窗口...
pause >nul