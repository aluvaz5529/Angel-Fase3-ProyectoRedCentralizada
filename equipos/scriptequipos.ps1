param($dominio,$sufijoDominio)
$domainComponent="dc="+$dominio+",dc="+$sufijoDominio
$equiposCsv=Read-Host "Introduce el fichero csv de Equipos:"
$fichero= import-csv -Path $equiposCsv -delimiter ":"
foreach($line in $fichero)
$pathObject=$line.Path+","+$domainComponent
New-ADComputer -Enabled:$true -Name:$line.Computer -Path:$pathObject -SamAccountName:$line.Computer
