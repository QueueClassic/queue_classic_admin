module QueueClassicAdmin::QueueClassicSpecHelper
  def create_job_qc_job(args = {})
    QueueClassicAdmin::QueueClassicJob.new.tap do |job|
      args.each do |k,v|
        job.send("#{k}=", v)
      end
      job.q_name ||= 'default'
      job.method ||= 'puts'
      job.args ||= []
      job.save!
    end
  end
end

RSpec.configure do |c|
  c.include QueueClassicAdmin::QueueClassicSpecHelper
end
