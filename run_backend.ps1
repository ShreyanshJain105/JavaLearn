Get-Content .env | ForEach-Object {
    if ($_ -notmatch '^\s*#' -and $_ -match '^\s*(.*?)\s*=\s*(.*)\s*$') {
        $name = $matches[1]
        $value = $matches[2].Trim("'").Trim('"')
        [Environment]::SetEnvironmentVariable($name, $value, "Process")
    }
}
./gradlew bootRun > boot_error3.log 2>&1
