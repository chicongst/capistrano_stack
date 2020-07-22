set :bucket, ENV['AWS_DEV_BUCKET_NAME']

set :local_theme_path, fetch(:local_app_path).join(fetch('/path/dist'))

set :deployment_path, fetch(:local_theme_path)

#s3 path
set :target_path, ''

set :bucket_write_options, {
    cache_control: "max-age=31556926, public"
}

set :object_write_options, {
    '*.js' => { content_encoding: 'gzip' },
    '*.css' => { content_encoding: 'gzip' },
    '*.txt' => { content_encoding: 'gzip' }
}

set :redirect_options, {
}

#CloudFront invalidation
set :distribution_id, ENV['AWS_DEV_DISTRIBUTION_ID']
set :invalidations, [ "/index.html" ]
#set :exclusions, []

before "deploy:symlink:release","s3:upload_files"
