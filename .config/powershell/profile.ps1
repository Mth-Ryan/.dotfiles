# ____                            _          _ _ 
#|  _ \ _____      _____ _ __ ___| |__   ___| | |
#| |_) / _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
#|  __/ (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
#|_|   \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|

# File:    profile.ps1
# Author:  Mateus Ryan <mthryan@protonmail.com>
# Licence: MIT

# User Config

# Go
$env:GOPATH = "${env:HOME}/.go"
$env:GOBIN  = "${env:GOPATH}/bin"

# Path
$extraPath = @(
    "${env:HOME}/.asdf/bin"
    "${env:HOME}/.asdf/shims"
    "${env:HOME}/.cargo/bin"
    $env:GOBIN
)

foreach ($folder in $extraPath) {
    $env:PATH += ":$($folder)"
}


# Prompt Config
$user_name = $env:USERNAME

Set-PSReadLineOption -colors @{
    Command            = "Blue"
    Comment            = "DarkGray"
    ContinuationPrompt = "Blue"
    Keyword            = "Yellow"
    Number             = "Cyan"
    Operator           = "Magenta"
    Parameter          = "DarkGray"
    String             = "Green"
    Variable           = "Gray"
}

function customPath {
    $current_dir = (Get-Location).Path
    $pattern = "/home/$($user_name)"

    if ($current_dir -eq $pattern) {
        return "  $($user_name) "
    }
    elseif ($current_dir.StartsWith($pattern)) {
        return " $($current_dir) ".Replace($pattern, "~")
    }
    else {
        return " $($current_dir) "
    }
}

function gitBranch {
    $branch = "";
	git branch | foreach {
		if ($_ -match "^\* (.*)"){
			$branch += $matches[1]
            return " $($branch)  "
		}
	}
    return ""
}

function prompt {
    # Glyphs
    $icon    = "  "
    $sep     = ""
    $lastSep = ""
    
    $path = customPath
    $git_branch = gitBranch
    
    Write-Host $icon -foregroundColor White                         -NoNewline
    Write-Host $sep  -backgroundColor Yellow -foregroundColor Black -NoNewline
    Write-Host $path -backgroundColor Yellow -foregroundColor Black -NoNewline

    if ($git_branch) {
        Write-Host $sep        -backgroundColor DarkGray -foregroundColor Yellow -NoNewline
        Write-Host $git_branch -backgroundColor DarkGray -foregroundColor White  -NoNewline
        Write-Host $lastSep    -foregroundColor DarkGray                         -NoNewline
    }
    else {
        Write-Host $lastSep -foregroundColor Yellow -NoNewline
    }

    return " "
}
