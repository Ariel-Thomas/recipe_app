A webapp that handles recipes and presents them in an interesting manner.

[Currently hosted on Heroku](http://mysterious-taiga-1810.herokuapp.com/)

Requires Imagemagick to be installed for the paperclip gem to function properly.

Set to use Amazon S3 in production.  Set AWS_BUCKET, AWS_ACCESS_KEY_ID, and AWS_SECRET_ACCESS_KEY.  If you are using Heroku as your production environment this can be achieved with heroku config:add VARIABLE=VALUE.