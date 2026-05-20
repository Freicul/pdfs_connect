<#
.SYNOPSIS
    Script en PowerShell para unir múltiples archivos PDF en uno solo usando Python.
.AUTHOR
    Freicul
#>

param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$TodosLosArgumentos
)

$Resultado = $TodosLosArgumentos[-1]
$ArchivosInput = $TodosLosArgumentos[0..($TodosLosArgumentos.Length - 2)]

if ($Resultado.EndsWith(".pdf") -and $ArchivosInput.Length -eq 0) {
    Write-Host "Falta especificar el archivo de salida o necesitas más archivos." -ForegroundColor Red
    return
}

$listaPython = $ArchivosInput | ForEach-Object { "'$_'" }
$listaStr = "[" + ($listaPython -join ", ") + "]"

python -c "from pypdf import PdfWriter; m = PdfWriter(); [m.append(f) for f in $listaStr]; m.write('$Resultado'); m.close()"
Write-Host "¡Genial! Se unieron $($ArchivosInput.Length) archivos en: $Resultado" -ForegroundColor Green