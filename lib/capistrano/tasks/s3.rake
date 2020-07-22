require('capistrano/s3')
require ('fileutils')

namespace :s3 do
    task :clear_bucket do
      #FileUtils.rm('.last_published')
    end

    task :wait_for_invalidation do
      Capistrano::S3::Publisher.check_invalidation(fetch(:region), fetch(:access_key_id),
                                                   fetch(:secret_access_key),
                                                   fetch(:distribution_id),
                                                   fetch(:stage))
    end

    task :upload_files do
      extra_options = {
        write: fetch(:bucket_write_options),
        redirect: fetch(:redirect_options),
        object_write: fetch(:object_write_options),
        prefer_cf_mime_types: fetch(:prefer_cf_mime_types)
      }
      Capistrano::S3::Publisher.publish!(fetch(:region), fetch(:access_key_id),
                                         fetch(:secret_access_key), fetch(:bucket),
                                         fetch(:deployment_path), fetch(:target_path),
                                         fetch(:distribution_id), fetch(:invalidations),
                                         fetch(:exclusions), fetch(:only_gzip), extra_options,
                                         fetch(:stage))
    end

end
