$equiposCsv=Read-Host "Introduce el fichero csv de Equipos:"
$fichero= import-csv -Path $equiposCsv -delimiter ":"
foreach($line in $fichero)
	{
New-ADComputer -Enabled:$true -Name:$line.Computer -Path:$line.Path -SamAccountName:$line.Computer
	}
