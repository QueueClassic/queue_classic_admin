
module QueueClassicAdmin
  class Stats

    def running_job_count
      QueueClassicJob.where("locked_at IS NOT NULL").count
    end

  end
end
