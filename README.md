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

Copy and run the migrations

    rake queue_classic_admin:install:migrations
    rake db:migrate

Mount in your rails app config/routes.rb file

    mount QueueClassicAdmin::Engine => "/queue_classic_admin"

Add the following asset dependencies to your Gemfile

```ruby
gem "twitter-bootstrap-rails"
gem "jquery-rails"
```

# Configuration

## Custom searchable fields

```ruby
QueueClassicJob.searchable_columns << :my_custom_fields

```

## Custom job action

```ruby
QueueClassicAdmin.add_custom_action "Retry" do |job|
  job.q_name = "low"
  job.save!
end
```

# Development

You can develop with POW by configuring it like so:

```bash
ln -s $PWD/spec/dummy ~/.pow/qc-admin
(cd spec/dummy && rake db:create:all db:migrate)

ln -s $PWD/spec/dummy-no-later ~/.pow/qc-admin-no-later
(cd spec/dummy-no-later && rake db:create:all db:migrate)
```

Then go to [http://qc-admin.dev/](http://qc-admin.dev/).
