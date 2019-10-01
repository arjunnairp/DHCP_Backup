#——————————————————————————————–#
# Script_Name : DHCP_Backup.ps1
# Description : Create a subfolder inside %systemroot%\system32\dhcp\backup and copy the dhcp backup files to it.
# Requirements : Windows 2008/R2 + DNS Management console Installed
# Version : 2
# Changes:
# v2: Detects dhcp interval and backup location from registry. Near 0 Manual intervention  - Oct 2019
# Date : January 2019
# Created by Arjun N
# Disclaimer:
# THE SCRIPT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
# AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
# OUT OF OR IN CONNECTION WITH THE SCRIPT OR THE USE OR OTHER DEALINGS IN THE SCRIPT.
#——————————————————————————————-#
$ErrorActionPreference = "Stop"
$key = 'HKLM:\SYSTEM\CurrentControlSet\Services\DHCPServer\Parameters'
$bkpint = (Get-ItemProperty -Path $key -Name BackupInterval).BackupInterval
$Bkppth = (Get-ItemProperty -Path $key -Name BackupDatabasePath).BackupDatabasePath

$backup = {
$FileName = "sched_"+(Get-Date).tostring("dd-MM-yyyy-hh-mm-ss")
$dirName = New-Item -ItemType directory -Path "$Bkppth\$FileName" -Force
Get-ChildItem "c:\windows\system32\dhcp\backup"| Where-Object{$_.Name -notlike "sched*"} | Copy-Item -Destination $dirName -Recurse -Force
}

if((($bkpint.gettype().Name) -eq 'int32') -and (Test-Path $Bkppth)){
&$backup
}

if(-not(Test-Path $Bkppth))
{
Write-Host $Bkppth unreachable... Check DHCP settings and $key }

elseif((($bkpint.gettype().Name) -ne 'int32'))
{
Write-Host Backup Interval Missing... Check $key}
