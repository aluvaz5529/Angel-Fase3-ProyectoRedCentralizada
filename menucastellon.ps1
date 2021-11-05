#Fuente: https://gallery.technet.microsoft.com/scriptcenter/Menu-simple-en-PowerShell-95e1f923

#----------------Funcion Submenu  -------------#
function mostrar_Submenu
{
     param (
           [string]$Titulo = 'Submenu.....'
     )
     Clear-Host 
     Write-Host "================$Titulo================"
    
     Write-Host "1: Crear Unidades Organizativas."
     Write-Host "2: Crear Grupos."
     Write-Host "2: Crear Usuarios y equipos."
     Write-Host "s: "
do
{
     $input = Read-Host "Por favor, pulse una opcion"
     switch ($input)
     {
           '1' {
                
	$ficheroCsvUO=Read-Host "Introduce el fichero csv de UO's"
	$fichero = import-csv -Path $ficheroCsvUO -delimiter :
	foreach($line in $fichero)
	{
	   New-ADOrganizationalUnit -Description:$line.Description -Name:$line.Name -Path:$line.Path -ProtectedFromAccidentalDeletion:$true
	}
		
                return
           } 
	   
	   
	   '2' {
               
	       
	$gruposCsv=Read-Host "Introduce el fichero csv de Grupos"
	$fichero = import-csv -Path $gruposCsv -delimiter :
	foreach($linea in $fichero)

	{
		New-ADGroup -Name:$linea.Name -Description:$linea.Description -GroupCategory:$linea.Category -GroupScope:$linea.Scope -Path:$linea.Path
	}
	       
	       
	       
                return
           } 
	   
	   '3' {
                'Opcion 3'
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
                'Primera Opción' 
                pause
           } '2' { 
                Clear-Host  
                'Segunda Opción' 
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
