#version 2 creo que esta funciona


$fileUsersCsv=Read-Host "Introduce el fichero csv de los usuarios:"
$fichero = import-csv -Path $fileUsersCsv -Delimiter :
foreach($linea in $fichero)
{
$containerPath =$linea.Path+"OU=dep-castellon-upv"+$domainComponent
}
$passAccount=ConvertTo-SecureString $linea.DNI -AsPlainText -force

$nameShort=$linea.Name+'.'+$linea.FirstName
	$Surnames=$linea.FirstName+' '+$linea.LastName
	$nameLarge=$linea.Name+' '+$linea.FirstName+' '+$linea.LastName
	$email=$nameShort+"@"+$dominio+"."+$sufijoDominio

$nameShort=$linea.Name+'.'+$linea.FirstName+$linea.LastName

[boolean]$Habilitado=$true
	
$ExpirationAccount = $linea.ExpirationAccount
    	$timeExp = (get-date).AddDays($ExpirationAccount)

New-ADUser -SamAccountName $nameShort -UserPrincipalName $nameShort -Name $nameShort `
		-Surname $Surnames -DisplayName $nameLarge -GivenName $linea.Name -LogonWorkstations:$linea.Computer `
		-Description "Cuenta de $nameLarge" -EmailAddress $email `
		-AccountPassword $passAccount -Enabled $Habilitado `
		-CannotChangePassword $false -ChangePasswordAtLogon $true `
		-PasswordNotRequired $false -Path $containerPath -AccountExpirationDate $timeExp

$cnGrpAccount="Cn="+$linea.Group+","+$containerPath
	Add-ADGroupMember -Identity $cnGrpAccount -Members $nameShort











#version1








$dominio="campus-castellon"
$sufijo="es"
$dc="dc="+$dominio+",dc="+$sufijo

{
  Import-Module ActiveDirectory #Se carga el módulo
}

$fichero_csv=Read-Host "Introduce el fichero csv de los usuarios"
$fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter :                  
foreach($linea_leida in $fichero_csv_importado)
{ 
  $rutaContenedor = $linea_leida.ContainerPath+","+$dc 
  $passAccount=ConvertTo-SecureString $linea_leida.AcountPassword -AsPlainText -force
    
    $name=$linea_leida.Name
    $nameShort=$linea_leida.Name+'.'+$linea_leida.Surname
    $Surnames=$linea_leida.Surname+' '+$linea_leida.Surname2
    $nameLarge=$linea_leida.Name+' '+$linea_leida.Surname+' '+$linea_leida.Surname2

    New-ADUser `
            -SamAccountName $nameShort `
            -UserPrincipalName $nameShort `
            -Name $nameShort `
            -Surname $Surnames `
            -DisplayName $nameLarge `
            -GivenName $name `
            -LogonWorkstations:$linea.Computer `
            -Description $linea_leida.Description `
            -EmailAddress $email `
            -AccountPassword $passAccount `
            -Enabled $true `
            -CannotChangePassword $false `
            -ChangePasswordAtLogon $true `
            -Path $rutaContenedor

}





