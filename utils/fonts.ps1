#! /bin/env pwsh

$fonts = @{
    mesloNF = @{
        url = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20"
        types = @( "Regular.ttf", "Bold.ttf", "Italic.ttf", "Bold%20Italic.ttf" )
    }
}

$fontsPath = "$env:HOME/.local/share/fonts"

# Creating fonts folder
New-Item -ItemType "directory" -Path $fontsPath -Force

# WebClient
$client = New-Object System.Net.WebClient

foreach ( $font in $fonts.GetEnumerator() ) {
    $baseUrl = $font.Value.url
    $path = "$($fontsPath)/$($font.Name)"

    New-Item -ItemType "directory" -Path $path -Force

    foreach ( $type in $font.Value.types ) {
        $url  = "$($baseUrl)$($type)"
        $file = "$($font.Name) $($type)".Replace("%20", " ")

        $client.DownloadFile($url, "$path/$file")
    }
}

