require 'queue_classic'
QC::Conn.connection = ActiveRecord::Base.connection.raw_connection

