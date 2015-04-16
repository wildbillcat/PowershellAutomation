#REQUIRES -Version 4.0
#REQUIRES -Module ActiveDirectory
<#
.Synopsis
   This adds some users to the logged in user's outlook Contacts list
.DESCRIPTION
   This is a script that finds some users in the active directory and then populates
   them into the logged in user's outlook. Need RSAT or Active Directory Powershell
   Credit for the CSV Import script this was based off of:
   http://itmicah.wordpress.com/2013/11/14/add-contacts-to-outlook-using-powershell-and-a-csv-file/
.EXAMPLE
   .\ContactGenerator.ps1 
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>
function Add-Contact {
    param ($user)
    $newcontact = $contacts.Items.Add()
    $newcontact.Email1Address = $user.Email
    $FirstName = $user.Givenname
    $LastName = $user.Surname
    $newcontact.FirstName = $FirstName
    $newcontact.LastName = $LastName
    $newcontact.FullName = "$FirstName $LastName"
    $newcontact.Save()
}

# Open Outlook and get contactlist
$outlook = new-object -com Outlook.Application -ea 1
$contacts = $outlook.session.GetDefaultFolder(10)

#This Snippet just lists all the outlook properties you could populate with the add contact function, depending on what is in the AD.
"Below is a list of properties the newcontact has."
$newcontact = $contacts.Items.Add()
$Props = $newcontact | gm -MemberType property | ?{$_.definition -like 'string*{set}*'}
$newcontact.Delete()
$Props | ForEach-Object {$_.Name}


#Get AD Users :::
$users = Get-ADUser -SearchBase 'OU=Sales,DC=test,DC=com' -Filter '*' -Properties *

#If you run this at the command line, it will tell you all the properies in your AD for a user, which you can then match up in
#the add contact function to make more detailed contacts.
#Get-ADUser UserID -Properties *

# Add contacts found in AD Query
foreach ($user in $users) {
    Add-Contact $user
}

