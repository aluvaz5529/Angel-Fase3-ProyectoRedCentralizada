#Fuente: https://gallery.technet.microsoft.com/scriptcenter/Menu-simple-en-PowerShell-95e1f923
function crearUo {
                
	$ficheroCsvUO=Read-Host "Introduce el fichero csv de UO's"
	$fichero = import-csv -Path $ficheroCsvUO -delimiter :
	foreach($line in $fichero)
	
	   New-ADOrganizationalUnit -Description:$line.Description -Name:$line.Name -Path:$line.Path -ProtectedFromAccidentalDeletion:$true
	}
	
function creargrupo{

$gruposCsv=Read-Host "Introduce el fichero csv de Grupos"
$fichero = import-csv -Path $gruposCsv -delimiter :
foreach($linea in $fichero)

function crearequipo
{
$equiposCsv=Read-Host "Introduce el fichero csv de Equipos:"
$fichero= import-csv -Path $equiposCsv -delimiter ":"
foreach($line in $fichero)
	
New-ADComputer -Enabled:$true -Name:$line.Computer -Path:$line.Path -SamAccountName:$line.Computer	
}




	New-ADGroup -Name:$linea.Name -Description:$linea.Description -GroupCategory:$linea.Category -GroupScope:$linea.Scope -Path:$linea.Path
}





#----------------Funcion Submenu  -------------#
function mostrar_Submenu
function crearUO


{
     param (
           [string]$Titulo = 'Submenu.....'
     )
     Clear-Host 
     Write-Host "================$Titulo================"
    
     Write-Host "1: Crear Unidades Organizativas."
     Write-Host "2: Crear Grupos."
     Write-Host "3: Crear Usuarios."
     Write-Host "4: Crear Equipos."
     Write-Host "s: salir"
do
{
     $input = Read-Host "Por favor, pulse una opcion"
     switch ($input)
     {
           '1'{
	   crearUO
              return} 
	   
	   
	   '2' {
             creargrupo
	  	return} 
	   
	   '3' {
                'Opcion 3'
                return
           } 
	   
	   4' {
                crearequipo
                return
           } 
	   
	      
     }
}
until ($input -eq 's')
}



#Función que nos muestra un menú por pantalla con 3 opciones, donde una de ellas es para acceder
# a un submenú) y una última para salir del mismo.

function mostrarMenu 
{ 
     param ( 
           [string]$Titulo = 'Selección de opciones' 
     ) 
     Clear-Host 
     Write-Host "================  $Titulo  ================" 
      
     
     Write-Host "1. creación de la estructura lógica" 
     Write-Host "2. Eliminación de la estructura lógica" 
     Write-Host "3. Submnenu" 
     Write-Host "s. Presiona 's' para salir" 
}

do 
{ 
     mostrarMenu 
     $input = Read-Host "Elegir una Opción" 
     switch ($input) 
     { 
           '1' { 
	   Clear-Host
                "aqui meter todas las funciones los nombres"
                pause}
		
		
		
		
		
		
           } '2' { 
                Clear-Host  
                 Set-ADorganizationalUnit -Identify "OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es"-ProtectedFromAccidentalDeletion $false
		 Remove-ADorganizationalUnit-Identify "OU=dep-castellon-upv,DC=castellon,DC=upv,DC=es" -Recursive
                pause
           } '3' {  
                mostrar_Submenu      
           } 's' {
                'Saliendo del script...'
                return 
           }  
     } 
     pause 
} 
until ($input -eq 's') 
