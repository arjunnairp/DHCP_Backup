#——————————————————————————————–#
# Script_Name : DHCP_Backup.ps1
# Description : Create a subfolder inside %systemroot%\system32\dhcp\backup and copy the dhcp backup files to it.
# Requirements : Windows 2008/R2 + DNS Management console Installed
# Version : 1
# Date : January 2019
# Created by Arjun N
# Disclaimer:
# THE SCRIPT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
# AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
# OUT OF OR IN CONNECTION WITH THE SCRIPT OR THE USE OR OTHER DEALINGS IN THE SCRIPT.
#——————————————————————————————-#
$FileName = "sched_"+(Get-Date).tostring("dd-MM-yyyy-hh-mm-ss")
$dirName = New-Item -ItemType directory -Path "c:\windows\system32\dhcp\backup\$FileName" -Force
Get-ChildItem "c:\windows\system32\dhcp\backup"| Where-Object{$_.Name -notlike "sched*"} | Copy-Item -Destination $dirName -Recurse -Force