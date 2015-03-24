# Queue Classic Admin

[![Build Status](https://travis-ci.org/QueueClassic/queue_classic_admin.png)](https://travis-ci.org/QueueClassic/queue_classic_admin)

An admin interface for the [queue_classic](https://github.com/QueueClassic/queue_classic) gem.

**IMPORTANT**: this branch is for queue_classic 3.1. Support for queue_classic-later has been removed and replaced by queue_classic 3.1's implementation of scheduling instead.  See the [queueclassic-2-support](https://github.com/QueueClassic/queue_classic_admin/tree/queueclassic-2-support) and [queueclassic-3-support](https://github.com/QueueClassic/queue_classic_admin/tree/queueclassic-3-support) branches for prior version support.

![qc admin](https://f.cloud.github.com/assets/148622/865030/9b1b2610-f62e-11e2-8908-8c271bfe0f6c.png)

# Features

* Support for QueueClassic 3.1's future job scheduling: **enqueue_at()** and **enqueue_in()**
* Support for custom columns
* Delete entire queues
* Delete jobs
* Search


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

## Custom action on matching jobs

```ruby
QueueClassicAdmin.add_bulk_custom_action "Retry" do |jobs|
  jobs.update_all(q_name: "low")
end
```

# Development

```bash
git clone git@github.com:rainforestapp/queue_classic_admin.git
```

You can develop with POW by configuring it like so:

```bash
ln -s $PWD/spec/dummy ~/.pow/qc-admin
(cd spec/dummy && bundle exec rake db:create:all db:migrate)
# Run the engine's migration.
bundle exec rake db:migrate
(cd spec/dummy && bundle exec rake db:schema:dump)
```

Then go to [http://qc-admin.dev/](http://qc-admin.dev/).
