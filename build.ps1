$CertRoot = "$PSScriptRoot\cert"
If (-Not (Test-Path $CertRoot))
{
    New-Item $CertRoot -Type Directory
}

If (-Not (Test-Path $CertRoot\cacert.pem))
{
    $url = "http://curl.haxx.se/ca/cacert.pem"
    $output = "$CertRoot\cacert.pem"

    Invoke-WebRequest -Uri $url -OutFile $output
}

Set-Item -Path env:SSL_CERT_FILE -Value ("$PSScriptRoot\cert\cacert.pem")
ruby -rnet/https -e "Net::HTTP.get URI('https://github.com')"

bundle exec jekyll s -w
