$svnUrl = "https://subversion.carmax.org:8080/svn/kmx/Architecture/Server_Patching/ServerTestSet"
$svnLocalPath = ".\test"

svn checkout $svnUrl $svnLocalPath --non-interactive --no-auth-cache --username "kmx\9500547" --password "**********" --trust-server-cert-failures=unknown-ca
