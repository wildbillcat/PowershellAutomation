<#  
.Synopsis  
    This is a general template that uses two lists to then perform actions. 
     
.Description  
    Whipped this up for Rob to compare two student lists and perform actions on them.
   
.Notes  
    Name     : ActionFilterScript.ps1  
     
#> 
$MasterList = Get-Content "textfile.txt"
$FilterList = Get-Content "textfile2.txt"

foreach($netID in $MasterList){
    if ($FilterList -contains $netID){
    #Do stuff to the netID that Exists on the Filter List and Master List
    echo "$netID is on the Filter list"
    }
    else{
    echo "$netID is not on the Filter list"
    #Do stuff to netID that Exists on Filter List and not Master List
    }
}