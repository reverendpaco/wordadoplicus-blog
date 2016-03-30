aws s3 sync /home/vagrant/site/public/ s3://blog.wordadoplicus.com/ --acl=public-read --delete --cache-control="max-age=1576800000" --exclude "*.html"
aws s3 sync /home/vagrant/site/public/ s3://blog.wordadoplicus.com/ --acl=public-read --delete --cache-control="max-age=0, no-cache" --include "*.html"

