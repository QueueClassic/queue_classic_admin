# Queue Classic Admin

An admin interface for the [queue_classic](https://github.com/ryandotsmith/queue_classic) and [queue_classic-later](https://github.com/dpiddy/queue_classic-later) gems.

![qc admin](https://f.cloud.github.com/assets/148622/865030/9b1b2610-f62e-11e2-8908-8c271bfe0f6c.png)


# Features

* Support for [queue_classic-later](https://github.com/dpiddy/queue_classic-later)
* Support for custom columns
* Delete entire queues
* Delete jobs

# Install

Copy and run the migrations

    rake queue_classic_admin:install:migrations
    rake db:migrate

Mount in your rails app config/routes.rb file

    mount QueueClassicAdmin::Engine => "/queue_classic_admin"

# TODO 

- Use something more lightweight than bootstrap
- Don't die if the queue_classic-later gem is missing
