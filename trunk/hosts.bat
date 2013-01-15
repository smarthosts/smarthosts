echo off
set release=11-12-11 23:00
set CU=123456789
del %windir%\System32\drivers\etc\hosts_temp /s /q
ipconfig /flushdns
takeown /f "%windir%\system32\drivers\etc\hosts" && icacls "%windir%\system32\drivers\etc\hosts" /grant administrators:F
attrib -s -h -r %windir%\system32\drivers\etc\hosts
if "%1" == "auto" (goto auto) else if "%1" == "typical" (goto typical) else goto begin

:begin
cls
echo ---------------------------------------------------------------------------
echo Hosts自动修改脚本
echo   更新时间：%release%
ver | find "5." >nul
if errorlevel 1 echo.& echo 请确认您已经以管理员身份运行。
echo ---------------------------------------------------------------------------
echo.
echo 1.完全安装/更新
echo 2.自定义安装/更新
echo.
echo 3.卸载
echo 4.工具
echo 5.更新说明
echo.
echo 6.退出
echo.
SET /P ST= 请输入相应序号(1-6)，回车键可直接安装:
echo.
if /I "%ST%"=="1" goto auto
if /I "%ST%"=="2" goto manualset
if /I "%ST%"=="3" goto delchar
if /I "%ST%"=="4" goto tools
if /I "%ST%"=="5" goto readme
if /I "%ST%"=="6" goto exit
if /I "%ST%"=="" goto install
exit

:readme
cls
echo ---------------------------------------------------------------------------
echo Hosts自动修改脚本
echo   更新时间：%release%
echo ---------------------------------------------------------------------------
echo 更新内容：
echo 整理代码，和图形版进行整合。
echo.
echo.
pause
goto begin

:tools
cls
echo ---------------------------------------------------------------------------
echo HOSTSp v5_final Tools @ %release%
echo ---------------------------------------------------------------------------
echo.
echo 1.恢复备份
echo 2.从IP添加..
echo 3.自行编辑hosts
echo 4.使用www.g.cn的IP
echo.
echo 5.返回上级
echo 6.退出

echo.
SET /P TT= 请输入相应序号(1-6)：
echo.
if /I "%TT%"=="1" goto remove
if /I "%TT%"=="2" goto manualip
if /I "%TT%"=="3" goto edithosts
if /I "%TT%"=="4" goto gcn
if /I "%TT%"=="5" goto begin
if /I "%TT%"=="6" goto exit
if /I "%TT%"=="" goto tools
exit

:auto

goto install

:manualset

cls

echo Hosts自动修改脚本
echo 请稍等一下,正在通过网络获取www.g.cn的IP地址...
echo.

for /f "tokens=2 delims=[]" %%i in ('ping -n 1 www.g.cn') do set IP=%%i
echo %IP%|findstr "203.208.45" >nul && echo 获取到正确IP：%IP% ||echo 获取到错误的IP，正在获取gpcom.azlyfox.com的IP地址 && for /f "tokens=2 delims=[]" %%i in ('ping -n 1 gpcom.azlyfox.com') do set IP=%%i

goto custom

:install

cls

echo Hosts自动修改脚本
echo 请稍等一下,正在通过网络获取www.g.cn的IP地址...
echo.

for /f "tokens=2 delims=[]" %%i in ('ping -n 1 www.g.cn') do set IP=%%i
echo %IP%|findstr "203.208.45" >nul && echo 获取到正确IP：%IP% ||echo 获取到错误的IP，正在获取gpcom.azlyfox.com的IP地址 && for /f "tokens=2 delims=[]" %%i in ('ping -n 1 gpcom.azlyfox.com') do set IP=%%i

goto doit

:gcn

cls

echo Hosts自动修改脚本 
echo 请稍等一下,正在通过网络获取www.g.cn的IP地址...
echo.

for /f "tokens=2 delims=[]" %%i in ('ping -n 1 www.g.cn') do set IP=%%i
echo %IP%|findstr "203.208" >nul && echo 获取到正确IP：%IP% ||echo 获取到非203.208开头的IP：%IP%，可能无法使用。 && SET /P ERR= 是否继续？(y/n)： 
if /I "%ERR%"=="n" goto begin
 
goto custom

:manualip

cls

echo Hosts自动修改脚本 
echo.


SET /P pingname= 请输入一个IP：
set IP=%pingname%
echo %IP%|findstr "203.208" >nul && echo 您输入的IP是：%IP% ||echo 您输入的IP是：%IP%，可能无法使用。 && SET /P ERR= 是否继续？(y/n)： && if /I "%ERR%"=="n" goto manualip

goto custom


:custom
cls
echo ---------------------------------------------------------------------------
echo HOSTSp v5_a1 Tools @ %release%
echo ---------------------------------------------------------------------------
echo.
echo                1.Google服务        2.Twitter         3.Facebook
echo                    4.Dropbox       5.苹果服务加速    

echo                 6.屏蔽广告      7.屏蔽Adobe更新服务器   
echo.
echo                       c 取消修改并返回主菜单
echo. 
echo 请输入相应序号,留空使用默认设置。
echo 支持多选,如"1346","1234567"。
echo.
SET /P CU=请选择：
if /I "%CU%"=="c" goto begin
echo.
goto doit
exit

:doit
if exist "%windir%\System32\drivers\etc\hosts_hpbak" (echo 备份文件已存在。) else copy %windir%\System32\drivers\etc\hosts %windir%\System32\drivers\etc\hosts_hpbak
takeown /f "%windir%\system32\drivers\etc\hosts" && icacls "%windir%\system32\drivers\etc\hosts" /grant administrators:F
attrib -s -h -r %windir%\system32\drivers\etc\hosts
cls
echo 正在将IP %IP% 写入hosts中。
echo 显示“找不到文件”属正常现象。
type %windir%\System32\drivers\etc\hosts|find "#THISISNOTE" /i /v|find "#HAC" /i /v|find "#HostsAutoChanger" /i /v|find "#HWrite" /i /v|findstr ".">>%windir%\System32\drivers\etc\hosts_temp
ren %windir%\System32\drivers\etc\hosts hosts_temp_del
ren %windir%\System32\drivers\etc\hosts_temp hosts
del %windir%\System32\drivers\etc\hosts_temp_del /s /q


echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_hosts START>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	smarthosts.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
if defined CU for /L %%i in (1,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 

:1
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Google Services START>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	www.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	music.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	music.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	music-streaming.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	large-uploads.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	uploadsj.clients.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	t.doc-0-0-sj.sj.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	talkgadget.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	groups.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	talkx.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	themes.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	market.android.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	toolbar.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	0-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	0.gvt0.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	0.gvt0.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	1.gvt0.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	1.gvt0.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	2.gvt0.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	2.gvt0.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	3.gvt0.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	4.gvt0.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	4.gvt0.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	5.gvt0.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	3hdrrlnlknhi77nrmsjnjr152ueo3soc-a-calendar-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	53rd6p0catml6vat6qra84rs0del836d-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	59cbv4l9s05pbaks9v77vc3mengeqors-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	8kubpeu8314p2efdd7jlv09an9i2ljdo-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	accounts.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	adstvca8k2ooaknjjmv89j22n9t676ve-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ajax.googleapis.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	apis.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks0.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks1.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks2.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks3.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks4.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks5.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks6.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks7.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks8.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bks9.books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	blogsearch.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.gmail.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	blogsearch.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	books.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	apps.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	appengine.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	browserchannel-docs.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	browserchannel-spreadsheets.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	browsersync.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	bt26mravu2qpe56n8gnmjnpv2inl84bf-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cache.pack.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	calendar.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	chrome.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	checkout.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	checkout.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients1.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients2.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients3.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients4.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients4.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients5.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients5.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients6.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients6.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients7.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients7.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	code.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	csi.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	desktop.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	desktop2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ditu.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	dl.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	dl-ssl.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	domains.googlesyndication.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	earth.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted-tbn0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted-tbn1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted-tbn2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted-tbn3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	feedback.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	feedburner.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	feedproxy.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	feeds.feedburner.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	finance.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	fonts.googleapis.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	g0.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	gg.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	googlehosted.l.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	id.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	id.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	id.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images0-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	i8brh95qor6r54nkl52hidj2ggcs4jgm-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images1-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images2-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images3-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images4-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images5-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images6-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images-lso-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images-pos-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	k6v18tjr24doa89b55o3na41kn4v73eb-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khm.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khms0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khms1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	labs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh1.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh1.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh2.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh2.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh3.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh3.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh4.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh4.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh5.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh5.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh6.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh6.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	m.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	maps.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	maps.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	maps-api-ssl.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mts0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mts1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mw2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	news.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	newsfeed-dot-latest-dot-rovio-ad-engine.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	nt0.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	nt1.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	nt2.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	nt3.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	oauth.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ode25pfjgmvpquh3b1oqo31ti5ibg5fr-a-calendar-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ob7f2qc0i50kbjnc81vkhgmb5hsv7a8l-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	picasa.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	picasaweb.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	picasaweb.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	places.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	profiles.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	project-slingshot-gp.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	video.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	voice.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	webcache.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	wenda.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	writely.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.google-analytics.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.googleadservices.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	writely-china.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.googleapis.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.googlelabs.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-calendar-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	goto.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	wire.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	desktop.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	jmt0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	id.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.gstatic.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	stat.top100.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	audio.top100.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	audio2.top100.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	music.googleusercontent.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www0.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www1.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www2.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www3.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www4.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	suggestqueries.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	suggestqueries.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients1.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients1.google.com.tw #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	linkhelp.clients.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	encrypted-tbn.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ghs46.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ghs46.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	gv-gadget.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	googlesharedspaces.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	blogsearch.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	browsersync.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	toolbarqueries.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	toolbarqueries.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	chrome.angrybirds.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r2303.latest.project-slingshot-hr.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	code.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	googlecode.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	chromium.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	earth-api-samples.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	gmaps-samples-flash.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	google-code-feed-gadget.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	closure-library.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	desktop.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs4.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs5.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs6.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs7.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs8.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	docs9.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	0.docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	1.docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	2.docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	3.docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	4.docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	5.docs.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets-china.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	writely-com.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	dl.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	auth.keyhole.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	geoauth.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mars.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	local.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	map.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	maps.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	kh.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	kh.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khmdb.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khm.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khm0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khm1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khm2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khm3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbk0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbk1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbk2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbk3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khms.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khms2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khms3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbks0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbks1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbks2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	cbks3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	khms.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mw1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	gg.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	csi.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ditu.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt0.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt1.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt2.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt3.google.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mts.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mts2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mts3.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mts.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	maps.gstatic.cn #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mobilemaps.clients.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	nt4.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	nt5.ggpht.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	photos.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	picasaweb.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh2.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	photos-ugc.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	wifi.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	wifi.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	t0.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	t1.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	t2.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	t3.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	g1.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	g2.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	g3.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt0.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt1.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt2.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt3.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt4.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt5.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt6.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	mt7.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	chart.apis.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	googleapis.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	chart.googleapis.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	maps.googleapis.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	translate.googleapis.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	googleapis-ajax.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	googleapis-ajax.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r3085-dot-latest-dot-project-slingshot-gp.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r3091-dot-latest-dot-project-slingshot-gp.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r3101-dot-latest-dot-project-slingshot-gp.appspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r70rmsn4s0rhk6cehcbbcbfbs31pu0va-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r8.pek01s01.c.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	r9.pek01s01.c.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	rbjhe237k979f79d87gmenp3gejfonu9-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s.ytimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s1.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s2.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s2.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s3.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s4.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s5.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	s6.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	safebrowsing.clients.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	safebrowsing-cache.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	sandbox.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	sb.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	scholar.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	scholar.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	services.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	sites.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	sketchup.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheet.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets0.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets1.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets2.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ssl.google-analytics.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ssl.gstatic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	blogger.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-00-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-08-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-0c-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-0g-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-0s-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-10-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	doc-14-7o-docs.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	lh0.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	music-onebox.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	static.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	translate.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	code-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	spreadsheets-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images-docs-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-gm-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-opensocial-sandbox.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-fc-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images7-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images8-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images9-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	1-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	2-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	3-focus-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-kix-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-onepick-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	images-onepick-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www-open-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	0-open-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	1-open-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	2-open-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	3-open-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	4fjvqid3r3oq66t548clrdj52df15coc-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	debh8vg7vd93bco3prdajidmm7dhql3f-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	hsco54a20sh11q9jkmb51ad2n3hmkmrg-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	qhie5b8u979rnch1q0hqbrmbkn9estf7-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	u807isd5egseeabjccgcns005p2miucq-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	upt14k1i2veesusrda9nfotcrbp9d7p5-a-oz-opensocial.googleusercontent.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	toolbarqueries.clients.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	toolbarqueries.google.com.hk #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	tools.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	translate.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	goo.gl #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	g.co #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	autoproxy-gfwlist.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	video-stats.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ytstatic.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	static.cache.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	accounts.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	magnifier.blogspot.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 203.208.46.180	smarthosts.googlecode.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	www.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	ytimg.l.google.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	i.ytimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	apiblog.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	clients1.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	gdata.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	help.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	i1.ytimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	i2.ytimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	i3.ytimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	i4.ytimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	insight.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo %IP%	m.youtube.com #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Google Services END>>%windir%\System32\drivers\etc\hosts
if defined CU for /L %%i in (2,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done

:2
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Twitter START>>%windir%\System32\drivers\etc\hosts
echo 199.59.149.210	t.co #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.148.139	userstream.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.149.243	assets2.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.149.243	assets3.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.149.243	static.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.29.36.124	platform.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.149.137	dev.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 219.76.10.138	platform0.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.148.206	help.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.148.206	support.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.28.97.55	p.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.169.75.33	si0.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.169.75.33	si1.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.169.75.33	si2.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.169.75.33	si3.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.169.75.33	si4.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.169.75.33	si5.twimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.148.243	scribe.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.148.138	betastream.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 184.106.20.99	posterous.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi40.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi41.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi42.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi43.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi44.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi45.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi46.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi47.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi48.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi49.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.143	oi50.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi51.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi52.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi53.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi54.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi55.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.17.70.144	oi56.tinypic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.58.234	twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.58.234	www.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.46.32	web7.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.58.204	web1.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.58.224	web2.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.58.200	web3.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.37.33.184	web4.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.37.75.16	web5.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 174.36.35.60	web6.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.228.120.92	web8.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 74.86.100.160	web9.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 74.86.87.236	web10.twitpic.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.58.188.34	bitly.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.94.0.61	a.yfrog.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.94.0.61	yfrog.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.94.0.61	www.yfrog.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 199.59.149.208	scribe.twitter.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.87.33.151	api.mobilepicture.com #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Twitter END>>%windir%\System32\drivers\etc\hosts
if defined CU for /L %%i in (3,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done

:3
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Facebook START>>%windir%\System32\drivers\etc\hosts
echo 66.220.149.25	facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.220.149.25	www.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.171.229.32	m.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.220.146.28	login.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.63.179.70	secure.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.171.242.28	apps.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.63.181.31	touch.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 118.214.114.110	s-static.ak.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.220.147.47	api.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.220.149.25	zh-CN.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.98	static.ak.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.98	b.static.ak.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.63.190.18	apps.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 118.214.190.105	profile.ak.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 120.29.145.50	vthumb.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.220.149.25	graph.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.120	b.static.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	creative.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.114	profile.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	s-hprofile-sf2p.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-a.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-b.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-c.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-d.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-e.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.98	photos-f.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-g.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 61.213.189.113	photos-h.ak.fbcdn.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.63.180.51	upload.facebook.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 64.213.102.26	fbcdn-profile-a.akamaihd.net #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Facebook END>>%windir%\System32\drivers\etc\hosts
if defined CU for /L %%i in (4,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done

:4
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Dropbox START>>%windir%\System32\drivers\etc\hosts
echo #HAC_Dropbox END>>%windir%\System32\drivers\etc\hosts
if defined CU for /L %%i in (5,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done


:5
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Apple START>>%windir%\System32\drivers\etc\hosts
echo 202.175.5.121	adcdownload.apple.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 202.175.5.121	deimos3.apple.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 202.175.5.121	appldnld.apple.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 202.175.5.121	swcdn.apple.com #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Apple END>>%windir%\System32\drivers\etc\hosts
if defined CU for /L %%i in (6,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done

:6
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Wikipedia START>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wikipedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wikipedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	bits.wikipedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	en.wikipedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	zh.wikipedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	simple.wikipedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wikibooks.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wikibooks.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	en.wikibooks.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	zh.wikibooks.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wikinews.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wikinews.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	en.wikinews.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	zh.wikinews.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wikiquote.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wikiquote.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	en.wikiquote.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	zh.wikiquote.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	zh.wikisource.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	en.wikisource.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wiktionary.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wiktionary.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	en.wiktionary.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	zh.wiktionary.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	bugs.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	bugzilla.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	commons.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	dumps.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	download.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	irc.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	ftp.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	ganglia.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	mail.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	meta.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	news.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	noc.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	kate.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	kohl.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	stats.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	ticket.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	tools.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.211	upload.wikimedia.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	wikimediafoundation.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.wikimediafoundation.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	mediawiki.org #HAC>>%windir%\System32\drivers\etc\hosts
echo 208.80.152.201	www.mediawiki.org #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Wikipedia END>>%windir%\System32\drivers\etc\hosts

if defined CU for /L %%i in (7,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done

:7
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Adobe activation block START>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 3dns-2.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 3dns-3.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 activate.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 activate-sea.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 activate-sjc0.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 adobe-dns.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 adobe-dns-2.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 adobe-dns-3.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 ereg.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 hl2rcv.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 practivate.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 wip3.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 activate.wip3.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 ereg.wip3.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 0.0.0.0 wwis-dubc1-vip60.adobe.com #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Adobe activation block END>>%windir%\System32\drivers\etc\hosts

if defined CU for /L %%i in (8,1,9)do if not "!CU:%%i=!"=="!CU!" call :%%i 
goto done

:8
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_Flickr START>>%windir%\System32\drivers\etc\hosts
echo 66.94.233.186 flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.94.233.186 www.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 68.142.214.43 static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 69.147.90.159 farm2.static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 76.13.18.78 farm3.static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 67.195.19.66 farm4.static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 76.13.18.79 farm5.static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 98.139.197.254 farm6.static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 98.139.102.46 farm7.static.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 98.136.43.76 geo.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 68.142.250.161 l.yimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 96.6.93.227 s.yimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 98.137.88.88 d.yimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 68.142.196.57 c5.ah.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 124.108.120.124 sa.edit.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 66.163.168.247 open.login.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.191.92.114 login.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.191.92.115 edit.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.191.121.31 up.flickr.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 209.191.105.102 adjax.flickr.yahoo.com #HAC>>%windir%\System32\drivers\etc\hosts
echo 204.0.5.35 content.yieldmanager.edgesuite.net #HAC>>%windir%\System32\drivers\etc\hosts
echo 204.0.5.34 us.js2.yimg.com #HAC>>%windir%\System32\drivers\etc\hosts
echo #HAC_Flickr END>>%windir%\System32\drivers\etc\hosts

goto done

REM :TEMPLATE
REM echo.>>%windir%\System32\drivers\etc\hosts
REM echo #HAC_NAME START>>%windir%\System32\drivers\etc\hosts
REM echo 1.2.3.4	www.examples.tld #HAC>>%windir%\System32\drivers\etc\hosts
REM echo #HAC_NAME END>>%windir%\System32\drivers\etc\hosts
REM echo %CU%|findstr "8" >nul && call :8
REM echo %CU%|findstr "9" >nul && call :9
REM goto done

:done
echo.>>%windir%\System32\drivers\etc\hosts
echo #HAC_hosts END>>%windir%\System32\drivers\etc\hosts
ipconfig /flushdns
cls
echo.

echo 您的hosts编辑完成.
echo.
echo.
echo.
pause

goto exit

:remove
cls
if exist "%windir%\System32\drivers\etc\hosts_hpbak" (goto removeit) else echo 备份文件不存在。您之前卸载过了吧？
goto begin

:delchar
type %windir%\System32\drivers\etc\hosts|find "#THISISNOTE" /i /v|find "#HAC" /i /v|find "#HostsAutoChanger" /i /v|find "#HWrite" /i /v|findstr ".">>%windir%\System32\drivers\etc\hosts_temp
ren %windir%\System32\drivers\etc\hosts hosts_temp_del
ren %windir%\System32\drivers\etc\hosts_temp hosts
del %windir%\System32\drivers\etc\hosts_temp_del /s /q
del %windir%\System32\drivers\etc\hosts_hpbak /s /q
del %windir%\System32\drivers\etc\hosts#THISISNOTE /s /q
del %windir%\System32\drivers\etc\hosts.tw /s /q
del %windir%\System32\drivers\etc\hosts_temp /s /q
goto begin

:removeit
ren %windir%\System32\drivers\etc\hosts hosts_del
ren %windir%\System32\drivers\etc\hosts_hpbak hosts
cls
del %windir%\System32\drivers\etc\hosts_del /s /q
del %windir%\System32\drivers\etc\hosts_hpbak /s /q
del %windir%\System32\drivers\etc\hosts_temp /s /q
goto tools

:edithosts
start %windir%\notepad.exe %windir%\system32\drivers\etc\hosts
cls
goto tools


:exit
REM takeown /a /f %windir%\System32\drivers\etc\hosts
REM attrib %windir%\System32\drivers\etc\hosts +s +r
REM echo y|cacls %windir%\System32\drivers\etc\hosts /g everyone:r
del temp.bat /s /q
cls
exit

REM Original version: https://plus.google.com/u/1/102216617437795883914/posts/iYS8CCubLTU
