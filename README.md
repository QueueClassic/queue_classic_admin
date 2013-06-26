# Queue Classic Admin

An admin interface for the [queue_classic](https://github.com/ryandotsmith/queue_classic) and [queue_classic-later](https://github.com/dpiddy/queue_classic-later) gems.

# Install

Copy and run the migrations

    rake queue_classic_admin:install:migrations
    rake db:migrate


Mount in your rails app config/routes.rb file

    mount QueueClassicAdmin::Engine => "/queue_classic_admin"


# TODO 

- Use something more lightweight than bootstrap
- Paginataion
- Don't die if the queue_classic-later gem is missing
