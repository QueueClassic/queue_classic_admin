# Queue Classic Admin

[![Build Status](https://travis-ci.org/rainforestapp/queue_classic_admin.png)](https://travis-ci.org/rainforestapp/queue_classic_admin)

An admin interface for the [queue_classic](https://github.com/ryandotsmith/queue_classic) and [queue_classic-later](https://github.com/dpiddy/queue_classic-later) gems.

![qc admin](https://f.cloud.github.com/assets/148622/865030/9b1b2610-f62e-11e2-8908-8c271bfe0f6c.png)


# Features

* Support for [queue_classic-later](https://github.com/dpiddy/queue_classic-later)
* Support for custom columns
* Delete entire queues
* Delete jobs

# Install

Mount in your rails app config/routes.rb file

```ruby
mount QueueClassicAdmin::Engine => "/queue_classic_admin"
```