Clear-Host
foreach ($file in (Get-ChildItem -Path C:\ -Include java.exe -Recurse))
{
    Get-ItemProperty $file
}