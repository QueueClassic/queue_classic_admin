class SetupQClassic < ActiveRecord::Migration[4.2]
  def up
    QC::Setup.create
  end

  def down
    QC::Setup.drop
  end
end
