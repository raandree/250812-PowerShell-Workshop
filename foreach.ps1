$numbers = 1..3
$chars = 'A'..'C'

$numbers | ForEach-Object{
    $number = $_
    $chars | ForEach-Object {
        $char = $_
        Write-Host "Processing number: $number and character: $char"
    }
}

$result = foreach ($number in $numbers)
{
    if ($number -eq 2) {
        continue
    }
    foreach ($char in $chars) {
        "$char - $number"
        Write-Host "Processing number: $number and character: $char"
    }
}
