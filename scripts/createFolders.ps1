
function Out-FileForce($path, $text) {

    if(Test-Path $path)
    {
        Out-File -inputObject $text -write -filepath $path
    }
    else
    {
        new-item -force -path $path -value $text -type file
    }
}

$filename = "C:\Users\jesper.kihlberg\Documents\GitHub\NaceIcons\NaceCodes.txt"
$rootFolder = "C:\Users\jesper.kihlberg\Documents\GitHub\NaceIcons\Icons"

if ([System.IO.File]::Exists( $filename)) {
    $naceCodes = Import-csv $filename -Delimiter "`t"
}
$prevLevel = 1
$prevFolders = @{0 = $rootFolder}
foreach ($elem in $naceCodes) {
    # write-host $elem
    $folderName = $elem.Code
    $lvl = $elem.Level/1
    $levelAbove = $lvl - 1
    $folderAbove = $prevFolders[$levelAbove]
    # foreach($elem in $prevFolders.Keys) {
    #     Write-Host "----------------" $elem " " $prevFolders[$elem]
    # }
    # Write-Host "levelAbove" $levelAbove $folderAbove
    $newFolder = "${folderAbove}\${folderName}"
    # if(!(Test-Path -Path $TARGETDIR )){
    #     New-Item -ItemType directory -Path $TARGETDIR
    # }
    $prevFolders[$lvl] = $newFolder
    Write-Host $lvl " " $prevLevel " " $newFolder "`t`t`t`t" $elem.Description
    Out-FileForce "${newFolder}\description.txt" $elem.Description
    $prevLevel = $lvl
}

# @{Order=18347; Level=1; Code=A; Parent=; Description=Agriculture, hunting and forestry}
# @{Order=18348; Level=2; Code=AA; Parent=A; Description=Agriculture, hunting and forestry}