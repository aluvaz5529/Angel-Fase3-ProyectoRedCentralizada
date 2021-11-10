function todo
{
                Clear-Host
                $ficheroCsvUO=Read-Host "Introduce el fichero csv de UO's:"
                $fichero = import-csv -Path $ficheroCsvUO -delimiter :
                foreach($line in $fichero)
{
   New-ADOrganizationalUnit -Description:$line.Descripcion -Name:$line.Name -Path:$linea.Path -ProtectedFromAccidentalDeletion:$false
}
                $gruposCsv=Read-Host "Introduce el fichero csv de Grupos"
                $fichero = import-csv -Path $gruposCsv -delimiter :
                foreach($linea in $fichero)
{
   New-ADGroup -Name:$linea.Name -Path:$linea.Path -Description:$linea.Description -GroupCategory:$linea.Category -GroupScope:$linea.Scope 
}
                $equiposCsv=Read-Host "Introduce el fichero csv de Equipos:"
                $fichero= import-csv -Path $equiposCsv -delimiter ":"
                foreach($line in $fichero)
{
   New-ADComputer -Enabled:$true -Name:$line.Computer -Path:$linea.Path -SamAccountName:$line.Computer
}
                $fichero_csv=Read-Host "Introduce el fichero csv de los usuarios:"
                $fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter : 			     
                foreach($linea in $fichero_csv_importado)
{

                $gmail=$linea.A+"."+$linea.B+"."+$linea.C
                $path="DC=castellon,DC=upv,DC=es"
  	            $rutaContenedor=$linea.Path+","+$path
  	            $passAccount=ConvertTo-SecureString $linea.Dni -AsPlainText -force
	            $name=$linea.Name
	            $nameShort=$linea.Name+' '+$linea.Surname1
	            $Surnames=$linea.Surname
	            $nameLarge=$linea.Name+'.'+$linea.Surname1+'.'+$linea.Surname2
	            $computerAccount=$linea.Computer
	            $email=$nameLarge+"@"+$gmail
                
	  
	            if (Get-ADUser -filter { name -eq $nameShort })
{
   $nameShort=$linea.Surname
}
	
	            [boolean]$Habilitado=$true
  	            If($linea.Hability -Match 'false') {$Habilitado=$false}
  	            $ExpirationAccount = $linea.DaysAccountExpire
 	            $timeExp = (get-date).AddDays($ExpirationAccount)
	
	            New-ADUser `
    		        -SamAccountName $nameShort `
   	 	            -UserPrincipalName $nameShort `
    		        -Name $nameShort `
		            -Surname $Surnames `
    		        -DisplayName $nameShort `
    		        -GivenName $nameShort `
    		        -LogonWorkstations:$linea.Computer `
		            -Description "Cuenta de $nameLarge" `
    		        -EmailAddress $email `
		            -AccountPassword $passAccount `
    		        -Enabled $Habilitado `
		            -CannotChangePassword $false `
    		        -ChangePasswordAtLogon $true `
		            -PasswordNotRequired $false `
    		        -Path $rutaContenedor `
    		        -AccountExpirationDate $timeExp
		    
		        Add-ADGroupMember -Identity $linea.Group -Members $nameShort
	
	
	            Import-Module C:\Users\Administrador\Desktop\FASE3\SetADUserLogonTime.psm1
	            Set-OSCLogonHours -SamAccountName $nameShort -DayofWeek Monday,Tuesday,Wednesday,Thursday,Friday -From $linea.Horario -To $linea.To
}
                pause
}
function quitartodo
{
                Clear-Host 
                Set-ADOrganizationalUnit -Identity "OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es" -ProtectedFromAccidentalDeletion $false
                Remove-ADOrganizationalUnit -Identity "OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es" -Recursive
                pause
}
function crearusuario

{
                Clear-Host
                $user=Read-Host "nombre de la cuenta que quieres habilitar"
                $path=Read-Host "Escribe el nombre del departamento de la cuenta"
                Enable-ADAccount -Identity "CN=$user, OU=$path,OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es"
                return
                pause
}



function crearuo
{
$name=Read-Host "Escribe el nombre de la uo a crear"
New-ADOrganizationalUnit -Name:$name -Path:"DC=castellon,DC=upv,DC=es" -ProtectedFromAccidentalDeletion:$true
}


function creargrupo
{
$descrip=Read-Host "Escribe la descripcion de este grupo"
$name=Read-Host "Escribe el nombre del grupo a crear"
New-LocalGroup -Name $name -Description $descrip
}
function crearquipo
{
$name=Read-Host "Escribe el nombre del equipo a crear"
New-ADComputer -Enabled:$true -Name $name -Path "OU=Equipos,OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es"
}


function deshabilitarusuario



{
                Clear-Host
		Write-Host "elige el departamento del que sea el usuario"
                $usuario=Read-Host "Escribe el nombre de la cuenta a deshabilitar"
                $path=Read-Host "Escribe el nombre del departamento"
                Disable-ADAccount -Identity "CN=$usuario, OU=$path,OU=,DC=castellon,DC=upv,DC=es"
                return
                pause
}
function deshabilitargrupo
{

$name=Read-Host "Escribe el nombre de la grupo a eliminar"
Remove-LocalGroup -Name $name
}
function deshabilitarequipo
{
$name=Read-Host "Escribe el nombre del equipo a eliminar"
Set-ADComputer -Identity "CN=$name, OU=Equipos,OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es" -Enable $false
}
function deshabilitaruo
{
Clear-Host 
$name=Read-Host "Escribe el nombre de la uo que quieres deshabilitar"
                Set-ADOrganizationalUnit -Identity "OU=$name, DC=castellon,DC=upv,DC=es" -ProtectedFromAccidentalDeletion $false
                Remove-ADOrganizationalUnit -Identity "OU=$name, DC=castellon,DC=upv,DC=es" -Recursive
                pause
}




function Submenu2
{
     param (
           [string]$Titulo = 'Submenu'
     )
     Clear-Host 
     Write-Host "================ $Titulo ================"
    
     Write-Host "1: Crear una UO"
     Write-Host "2: Crear un grupo"
     Write-Host "3: Crear un equipo"
     Write-Host "4: Crear un usuario"
     Write-Host "s: Volver al menu principal."
do
{
     $input = Read-Host "Por favor, pulse una opción"
     switch ($input)
     {
           '1' {
                Clear-Host
                crearuo
                return
           } '2' {
                Clear-Host
                creargrupo
                return
           } '3' {
                Clear-Host
                crearequipo
                return
           } '4' {
                Clear-Host
                crearusuario
                return
           } 's' {
                "Saliendo del submenu..."
                return
           } 
     }
}
until ($input -eq 'q')
}
function Submenu3
{
     param (
           [string]$Titulo = 'Submenu de Bajas'
     )
     Clear-Host 
     Write-Host "================ $Titulo ================"
    
     Write-Host "1: Baja una UO"
     Write-Host "2: Baja un Grupo"
     Write-Host "3: Baja un Equipo"
     Write-Host "4: Baja una usuario"
     Write-Host "s: Volver al menu principal."
do
{
     $input = Read-Host "Por favor, pulse una opción"
     switch ($input)
     {
           '1' {
               Clear-Host
                deshabilitaruo
                return
           } '2' {
                Clear-Host
                deshabilitargrupo
                return
           } '3' {
                Clear-Host
                deshabilitarequipo
                return
           } '4' {
                Clear-Host
                deshabilitarusuario
                return
           } 's' {
                "Saliendo del submenu..."
                return
           } 
     }
}
until ($input -eq 's')
}

function Submenu1
{
     param (
           [string]$Titulo = 'Submenu.....'
     )
     Clear-Host 
     Write-Host "================ $Titulo ================"
    
     Write-Host "1: Dar de baja un objeto"
     Write-Host "2: Dar de alta un objeto"
     Write-Host "3: Busqueda de un objeto"
     Write-Host "s: Volver al menu principal."
do
{
     $input = Read-Host "Por favor, pulse una opción"
     switch ($input)
     {
           '1' {
                Clear-Host
                Submenu3
                return
           } '2' {
                Clear-Host
                Submenu2
                return
           } '3' {
                Clear-Host
		dsquery user -name F*
                return
           } 's' {
                "Saliendo del submenu..."
                return
           } 
     }
}
until ($input -eq 'q')
}



#Función que nos muestra un menú por pantalla con 3 opciones, donde una de ellas es para acceder
# a un submenú) y una última para salir del mismo.

function mostrarMenu 
{ 
     param ( 
           [string]$Titulo = 'Selección de opciones' 
     ) 
     Clear-Host 
     Write-Host "================ $Titulo================" 
      
     
     Write-Host "1. Crear la estructura lógica" 
     Write-Host "2. Eliminar la estructura lógica" 
     Write-Host "3. listar objetos del subdominio" 
     Write-Host "4. Gestión de objetos" 
     Write-Host "s. Pulsa 's' para salir" 
}

do 
{ 
     mostrarMenu 
     $input = Read-Host "Elegir una Opción" 
     switch ($input) 
     { 
           '1' { 
                todo
           } '2' { 
                quitartodo
           } '3' {  
                Clear-Host
		 Get-ADUser -filter * -SearchBase "dc=castellon,dc=upv,dc=es" | Select sAMAccountName
                pause
           } '4' {  
                Clear-Host
                Submenu1      
           } 's' {
                'Saliendo del script...'
                return 
           }  
     } 
     pause 
} 
until ($input -eq 's')
