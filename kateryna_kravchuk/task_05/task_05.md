# Task 05: PowerShell

>Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)  

### Problem 1

#### Task

Suppose we have a text file that contains some file names, for example:  
`jobe`  
`/var/www/html/index.html`  
`/var/www/html/jobe`  
Write a <span style="color: red">PowerShell</span> script that takes the name of a text file as an argument and shows its content.  

*For example:*  

| Test | Input | Result |
| --- | --- | --- |
| # Test 1 | data1.txt | jobe  |
|  |  | /var/www/html/index.html |
| | | /var/www/html/jobe |

#### Solution  

```pwsh
#!/usr/bin/env pwsh

# check if no args provided
if ($args.Count -eq 0) {
    # get script's name to use in the error message
    $scriptName = [System.IO.Path]::GetFileName($PSCommandPath)
    Write-Error "Usage: ./$scriptName <paths_file>"
    exit 1
}

$paths_file = $args[0]
# ensure that file exists
if (Test-Path $paths_file) {
    # open & print out content
    Get-Content $paths_file
} else {
    Write-Error "File not found: $paths_file"
    exit 2
}
```  

#### Notes

##### Differences

`$0` in *Bash* refers to the script's name itself, however in *PowerShell* `$args[0]` refers to the first argument.  

##### Getting script's name to use later  

An automatic variable `$PSCommandPath` holds the full path of the currently running script.  
A .NET class `[System.IO.Path]` provides methods to handle file paths.  
A static method `GetFileName($variable)` extracts the filename.  

##### Cmdlets

`Test-Path` checks if a file (or folder) exists before proceeding.  
`Get-Content` displays the content of a file.  
`Write-Error` generates an error message *(e.g., if no arguments provided)*.  

---

### Problem 2

#### Task  

Write a shell script that takes arguments as a string of multiple words separated by spaces, and prints the words one per line.  

*For example:*  

| Test | Input | Result |
| --- | --- | --- |
| Test 1 | hello1 hello2 hello3 | hello1 |
| | | hello2 |
| | | hello3 |

#### Solution  

```pwsh
#!/usr/bin/env pwsh

# check if exactly one string provided
if ($args.Count -ne 1) {
    # get script's name to use in error message
    $scriptName = [System.IO.Path]::GetFileName($PSCommandPath)
    Write-Error "Usage: ./$scriptName '<string>'"
    exit 1
}

$input = $args[0]
$input -split " " | ForEach-Object { Write-Output $_ }
```  

#### Notes  

##### Alternatives for `ForEach-Object`

- *for loops:*  
`foreach ($arg in $args)`  
`for ($i = 1; $i -le n; $i++)`  
- *while loops:*  
`while ($i -le n)`

##### Alternatives for `Write-Output`

`Write-Host` (doesn't send output down the pipeline)  

---

### Problem 3

#### Task  

Write a <span style="color: red">PowerShell</span> script that creates 5 text files named <span style="color: red">file</span> followed by a file number starting from 0. For example, the files should be named <span style="color: red">file0.txt</span>, <span style="color: red">file1.txt</span>, and so on. Append a log message to a file named files.log for each file creation, stating that the file has been created, like The *file* ... *has been created*. Finally, output the contents of the <span style="color: red">files.log</span> file.  

*For example:*  

| Test | Result |
| --- | --- |
| # Test1 checks if script outs right content | The file 'file0.txt' has been created |
| | The file 'file1.txt' has been created |
| | The file 'file2.txt' has been created |
| | The file 'file3.txt' has been created |
| | The file 'file4.txt' has been created |

#### Solution  

```pwsh
#!/usr/bin/env pwsh

# specify log file & clear it
$log = "files.log"
Clear-Content -Path $log -ErrorAction SilentlyContinue

0..4 | ForEach-Object {
    $name = "file$_.txt"
    New-Item -Path $name -ItemType File -Force > $null 2>&1 # suppressing output
    "The file '$name' has been created" | Add-Content -Path $log
}

# add one line of white space
Add-Content -Path $log -Value ""

# print out logs
Get-Content -Path $log
```

#### Considerations about choices

1. `Add-Content -Path $log -Value ""` was used only for good-looking purposes, as a *test2* was failing without an added line in log file.  

Here's a *test2* desired output:  

| Test | Result |
| --- | --- |
| # Test2 checks if list of files is | The file 'file0.txt' has been created |
| ok./test.ps1 | The file 'file1.txt' has been created |
| | The file 'file2.txt' has been created |
| | The file 'file3.txt' has been created |
| | The file 'file4.txt' has been created |
| | *here goes a blank line* |
| | List of files started with 'file': |
| | file0.txt |
| | file1.txt |
| | file2.txt |
| | file3.txt |
| | file4.txt |
| | files.log |  

2. `Get-Content` was used over `Write-Host` so it can be processed further if needed (e.g., to provide output to the pipeline).  

3. `0..4 | ForEach-Object { $_ * 2 }` is slower and less efficient than traditional loops (e.g., `foreach` or `for`), but it's shorter and more readable, so I've chosen it over.  

#### Notes

##### Ways to clear output of running commands  

| Way | Purpose |Explanation |
| --- | --- | --- |
| `<Do-Command> > $null 2>&1` | general output | `> $null` redirects `$stdout` output to `$null` |
|  |  | `2>&1` redirects `$stderr` to normal output (which is already discarded by previous statement) |
| `-ErrorAction SilentlyContinue` | with *cmdlets* |  prevents *error* messages from being displayed |
| `[void]<Do-Command>` | object-returning commands | casts returned by command running object to `[void]` to discard it |
| `<Do-Command> \| Out-Null` | pipeline output | prevents any output from appearing |
| `$null = <Do-Command>` | normal output | uses sub-expression to run a command in & redirect it output to `$null` |
