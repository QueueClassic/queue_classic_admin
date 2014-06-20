
QueueClassicAdmin.add_custom_action "Retry" do |job|
  job.q_name = "low"
  job.save!
end
