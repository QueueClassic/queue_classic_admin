class AddQcLater < ActiveRecord::Migration
  def up
    QC::Later::Setup.create
  end

  def down
    QC::Later::Setup.drop
  end
end
