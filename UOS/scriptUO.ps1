$ficheroCsvUO=Read-Host "Introduce el fichero csv de UO's"
$fichero = import-csv -Path $ficheroCsvUO -delimiter :
foreach($line in $fichero)
{
   New-ADOrganizationalUnit -Description:$line.Description -Name:$line.Name -Path:$line.Path -ProtectedFromAccidentalDeletion:$false
}
#el ultimo parametro es lo que te evita que lo borres accidentalmente asi que si lo pones en false para hacer pruebas es mucho mas comodo y cuando tengas claro que esta bien pones true
